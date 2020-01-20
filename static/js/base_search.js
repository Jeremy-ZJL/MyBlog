window.addEventListener('DOMContentLoaded', function () {
    $('.header-nav-search').on('click', function (e) {
        e.stopPropagation();

        $('body').css('overflow', 'hidden');
        $('.search-popup')
            .addClass('show')
            .velocity('stop')
            .velocity('transition.expandIn', {
                duration: 300,
                complete: function () {
                    $('.search-popup input').focus();
                }
            });
        $('.search-mask')
            .velocity('stop')
            .velocity('transition.fadeIn', {
                duration: 300
            });

        initSearch();
    });

    $('.search-mask, .search-close').on('click', function () {
        closeSearch();
    });

    $(document).on('keydown', function (e) {
        // Escape <=> 27
        if (e.keyCode === Stun.utils.codeToKeyCode('Escape')) {
            closeSearch();
        }
    });

    var isXML = true;
    var search_path = 'static/search.json';

    if (!search_path) {
        search_path = 'search.xml';
    } else if (/json$/i.test(search_path)) {
        isXML = false;
    }

    var path = '/' + search_path;

    function initSearch() {
        $.ajax({
            url: path,
            dataType: isXML ? 'xml' : 'json',
            async: true,
            success: function (res) {
                var datas = isXML ? $('entry', res).map(function () {
                    // 将 XML 转为 JSON
                    return {
                        title: $('title', this).text(),
                        content: $('content', this).text(),
                        url: $('url', this).text()
                    };
                }).get() : res;

                var $input = $('.search-input input');
                var $result = $('.search-results');

                // 搜索对象（标题、内容）的权重，影响显示顺序
                var WEIGHT = {
                    title: 100,
                    content: 1
                };

                var searchPost = function () {
                    var searchText = $input.val().toLowerCase().trim();
                    // 根据空白字符分隔关键字
                    var keywords = searchText.split(/[\s]+/);
                    // 搜索结果
                    var matchPosts = [];

                    // 有多个关键字时，将原文字整个保存下来
                    if (keywords.length > 1) {
                        keywords.push(searchText);
                    }

                    // 防止未输入字符时搜索
                    if (searchText.length > 0) {
                        datas.forEach(function (data) {
                            var isMatch = false;

                            // 没有标题的文章使用预设的 i18n 变量代替
                            var title = (data.title && data.title.trim()) || '( 文章无标题 )';
                            var titleLower = title && title.toLowerCase();
                            // 删除 HTML 标签 和 所有空白字符
                            var content = data.content && data.content.replace(/<[^>]+>/g, '');
                            var contentLower = content && content.toLowerCase();
                            // 删除重复的 /
                            var postURL = data.url && decodeURI(data.url).replace(/\/{2,}/g, '/');

                            // 标题中匹配到的关键词
                            var titleHitSlice = [];
                            // 内容中匹配到的关键词
                            var contentHitSlice = [];

                            keywords.forEach(function (keyword) {
                                /**
                                 * 获取匹配的关键词的索引
                                 * @param {String} keyword 要匹配的关键字
                                 * @param {String} text 原文字
                                 * @param {Boolean} caseSensitive 是否区分大小写
                                 * @param {Number} weight 匹配对象的权重。权重大的优先显示
                                 * @return {Array}
                                 */
                                function getIndexByword(word, text, caseSensitive, weight) {
                                    if (!word || !text) return [];

                                    var startIndex = 0; // 每次匹配的开始索引
                                    var index = -1; // 匹配到的索引值
                                    var result = []; // 匹配结果

                                    if (!caseSensitive) {
                                        word = word.toLowerCase();
                                        text = text.toLowerCase();
                                    }

                                    while ((index = text.indexOf(word, startIndex)) !== -1) {
                                        var hasMatch = false;

                                        // 索引位置相同的关键词，保留长度较长的
                                        titleHitSlice.forEach(function (hit) {
                                            if (hit.index === index && hit.word.length < word.length) {
                                                hit.word = word;
                                                hasMatch = true;
                                            }
                                        });
                                        startIndex = index + word.length;
                                        !hasMatch && result.push({
                                            index: index,
                                            word: word,
                                            weight: weight
                                        });
                                    }

                                    return result;
                                }

                                titleHitSlice = titleHitSlice.concat(getIndexByword(keyword, titleLower, false,
                                    WEIGHT.title));
                                contentHitSlice = contentHitSlice.concat(getIndexByword(keyword, contentLower,
                                    false, WEIGHT.content));
                            });

                            var hitTitle = titleHitSlice.length;
                            var hitContent = contentHitSlice.length;

                            if (hitTitle > 0 || hitContent > 0) {
                                isMatch = true;
                            }

                            if (isMatch) {
                                ;
                                [titleHitSlice, contentHitSlice].forEach(function (hit) {
                                    // 按照匹配文字的索引的递增顺序排序
                                    hit.sort(function (left, right) {
                                        return left.index - right.index;
                                    });
                                });

                                /**
                                 * 给文本中匹配到的关键词添加标记，从而进行高亮显示
                                 * @param {String} text 原文本
                                 * @param {Array} hitSlice 匹配项的索引信息
                                 * @param {Number} start 开始索引
                                 * @param {Number} end 结束索引
                                 * @return {String}
                                 */
                                function highlightKeyword(text, hitSlice, start, end) {
                                    if (!text || !hitSlice || !hitSlice.length) return;

                                    var result = '';
                                    var startIndex = start;
                                    var endIndex = end;

                                    hitSlice.forEach(function (hit) {
                                        if (hit.index < startIndex) return;

                                        var hitWordEnd = hit.index + hit.word.length;

                                        result += text.slice(startIndex, hit.index);
                                        result += '<b>' + text.slice(hit.index, hitWordEnd) + '</b>';
                                        startIndex = hitWordEnd;
                                    });
                                    result += text.slice(startIndex, endIndex);

                                    return result;
                                }

                                var postData = {};
                                // 文章总的搜索权重
                                var postWeight = titleHitSlice.length * WEIGHT.title + contentHitSlice.length *
                                    WEIGHT.content;
                                // 标记匹配关键词后的标题
                                var postTitle = highlightKeyword(title, titleHitSlice, 0, title.length) || title;
                                // 标记匹配关键词后的内容
                                var postContent;
                                // 显示内容的长度
                                var SHOW_WORD_LENGTH = 200;
                                // 命中关键词前的字符显示长度
                                var SHOW_WORD_FRONT_LENGTH = 20;
                                var SHOW_WORD_END_LENGTH = SHOW_WORD_LENGTH - SHOW_WORD_FRONT_LENGTH;

                                // 截取匹配的第一个字符，前后共 200 个字符来显示
                                if (contentHitSlice.length > 0) {
                                    var firstIndex = contentHitSlice[0].index;
                                    var start = firstIndex > SHOW_WORD_FRONT_LENGTH ? firstIndex -
                                        SHOW_WORD_FRONT_LENGTH : 0;
                                    var end = firstIndex + SHOW_WORD_END_LENGTH;

                                    postContent = highlightKeyword(content, contentHitSlice, start, end);
                                } else { // 未匹配到内容，直接截取前 200 个字符来显示
                                    postContent = content.slice(0, SHOW_WORD_LENGTH);
                                }

                                postData.title = postTitle;
                                postData.content = postContent;
                                postData.url = postURL;
                                postData.weight = postWeight;
                                matchPosts.push(postData);
                            }
                        });
                    }

                    var resultInnerHtml = '';

                    if (matchPosts.length) {
                        // 按权重递增的顺序排序，使权重大的优先显示
                        matchPosts.sort(function (left, right) {
                            return right.weight - left.weight;
                        });

                        resultInnerHtml += '<ul>';
                        matchPosts.forEach(function (post) {
                            resultInnerHtml += '<li><a class="search-results-title" href="' + post.url + '">';
                            resultInnerHtml += post.title;
                            resultInnerHtml += '</a><div class="search-results-content">';
                            resultInnerHtml += post.content;
                            resultInnerHtml += '</div></li>';
                        });
                        resultInnerHtml += '</ul>';
                    } else {
                        resultInnerHtml += '<div class="search-results-none"><i class="fa fa-meh-o"></i></div>';
                    }

                    $result.html(resultInnerHtml);
                };

                $input.on('input', searchPost);
                $input.on('keypress', function (e) {
                    if (e.keyCode === Stun.utils.codeToKeyCode('Enter')) {
                        searchPost();
                    }
                });
            }
        });
    }

    function closeSearch() {
        $('body').css('overflow', 'auto');
        $('.search-popup')
            .removeClass('show')
            .velocity('stop')
            .velocity('transition.expandOut', {
                duration: 300
            });
        $('.search-mask')
            .velocity('stop')
            .velocity('transition.fadeOut', {
                duration: 300
            });
    }
}, false);