# SPDX-FileCopyrightText: 2022 Tim Hawes <me@timhawes.com>
#
# SPDX-License-Identifier: MIT

from allauth.account.models import EmailAddress
from django.contrib import admin
from django.contrib.auth import get_user_model
from django.contrib.auth.admin import UserAdmin

from nfctokens.admin import NFCTokenInline


class EmailAddressInline(admin.TabularInline):
    model = EmailAddress
    fields = ("email", "primary", "verified")
    readonly_fields = ("verified",)
    extra = 0


class CustomUserAdmin(UserAdmin):
    # list_display = (
    #     "username",
    #     "email",
    #     "first_name",
    #     "last_name",
    #     "is_staff",
    #     "is_member",
    # )
    # list_filter = ("member__membership_status",)
    # search_fields = (
    #     "username",
    #     "email",
    #     "first_name",
    #     "last_name",
    # )
    inlines = (
        EmailAddressInline,
        NFCTokenInline,
    )


admin.site.unregister(get_user_model())
admin.site.register(get_user_model(), CustomUserAdmin)
