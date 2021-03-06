# Generated by Django 2.2.6 on 2020-01-30 12:55

from django.db import migrations, models
import mdeditor.fields


class Migration(migrations.Migration):

    dependencies = [
        ('article', '0001_initial'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='articlepost',
            options={'verbose_name': '文章列表', 'verbose_name_plural': '文章列表'},
        ),
        migrations.AlterModelOptions(
            name='category',
            options={'verbose_name': '分类', 'verbose_name_plural': '分类'},
        ),
        migrations.AlterModelOptions(
            name='tags',
            options={'verbose_name': '标签', 'verbose_name_plural': '标签'},
        ),
        migrations.AlterField(
            model_name='articlepost',
            name='body',
            field=mdeditor.fields.MDTextField(verbose_name='正文'),
        ),
        migrations.AlterField(
            model_name='articlepost',
            name='tags',
            field=models.ManyToManyField(blank=True, to='article.Tags', verbose_name='标签'),
        ),
    ]
