#!/usr/bin/env python
# -*- coding: utf-8 -*- #

AUTHOR = u"nuit"
SITENAME = u"Eleventeen"
#SITESUBTITLE = u""
SITEURL = u'http://blog.hoeja.de'

THEME = "/home/jan/development/github/makujaho/pelican-themes/bootstrap-mathified/"

#GITHUB_URL = 'http://github.com/nv1t/'
#DISQUS_SITENAME = "eleventeen"
PDF_GENERATOR = False
REVERSE_CATEGORY_ORDER = True
LOCALE = ""
DEFAULT_PAGINATION = 5
DEFAULT_CATEGORY = "blog"

#PIWIK_URL = "piwik.hoeja.de"
#PIWIK_SITE_ID = 2

FEED_DOMAIN = SITEURL

FEED_RSS = 'feeds/all.rss.xml'
CATEGORY_FEED_RSS = 'feeds/%s.rss.xml'

TIMEZONE = 'Europe/Berlin'

DEFAULT_LANG='de'

DISPLAY_PAGES_ON_MENU=False

# Blogroll
LINKS =  (
    ('mkzer0', 'http://blog.unikorn.me/'),
    ('bakerolls','http://w8l.org'),
         )

# Social widget
SOCIAL = (('twitter', 'http://twitter.com/nv1t'),
          ('github','http://github.com/nv1t'),
          #('pastebin','http://paste.hoeja.de'),
         )

# TWITTER_USERNAME = 'nv1t'

# static paths will be copied under the same name
STATIC_PATHS = ["pictures",]
