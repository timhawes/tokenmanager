# SPDX-FileCopyrightText: 2022 Tim Hawes <me@timhawes.com>
#
# SPDX-License-Identifier: MIT

from django.contrib import admin
from django.urls import include, path
from django.views.generic.base import RedirectView

urlpatterns = [
    path("", RedirectView.as_view(url="nfctokens/", permanent=False), name="home"),
    path("accounts/", include("allauth.urls")),
    path("admin/", admin.site.urls),
    path("nfctokens/", include("nfctokens.urls")),
]
