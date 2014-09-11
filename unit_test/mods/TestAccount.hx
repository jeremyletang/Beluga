package mods;

import hunit.Assert;
import hunit.AssertException;
import hunit.HUnitTest;

import beluga.core.Beluga;
import beluga.module.account.Account;

import php.Lib;
import sys.db.Types;

class TestAccount implements HUnitTest {
    public var account: Account;
    public static var beluga: Beluga;
    public var user_id: Int;
    public var friend_id: Int;

    public function new() {}

    @before_class
    public function beforeClass() {
        beluga = Beluga.getInstance();
        account = beluga.getModuleInstance(Account);
        account.subscribe({login: "friend", password: "friend", password_conf: "friend", email: "friend"});
        account.login({login:"friend", password: "friend"});
        this.friend_id = account.getLoggedUser().id;
        account.logout();
    }

    @after_class
    public function afterClass() {
        beluga.cleanup();
    }

    @before
    public function beforeTest() {}

    @after
    public function afterTest() {
        account.logout();
    }

    @test
    public function canCreateAnAccountWithValidsDatas() {
        account.triggers.subscribeSuccess.add(this.canCreateAnAccountSuccess);
        account.triggers.subscribeFail.add(this.canCreateAnAccountFail);
        account.subscribe({login: "test", password: "test", password_conf: "test", email: "test"});
    }

    @test
    @should_fail
    public function cannotCreateAnAccountWithAnExistingUserName() {
        account.triggers.subscribeSuccess.add(this.canCreateAnAccountSuccess);
        account.triggers.subscribeFail.add(this.canCreateAnAccountFail);
        account.subscribe({login: "test", password: "test", password_conf: "test", email: "test"});
    }
    public function canCreateAnAccountSuccess(d: Dynamic) {}
    public function canCreateAnAccountFail(d: Dynamic) { Assert.fail2(); }


    @test
    public function canLogAnUserWithValidPasswordAndUserName() {
        account.login({login: "test", password: "test"});
        this.user_id = account.getLoggedUser().id;
        Assert.isTrue(account.getLoggedUser() != null);
    }

    @test
    public function cannotLogAnUserWithInvalidPasswordAndUserName() {
        account.login({login: "not_valid", password: "not_valid"});
        Assert.isTrue(account.getLoggedUser() == null);
    }

    @test
    public function canEditUserInformations() {
        var user = account.getLoggedUser();
        account.edit(user.id, "new_mail");
        Assert.eq(account.getLoggedUser().email, "new_mail");
    }

    @test
    public function canAddAFriendWichAlreadyExist() {
        account.triggers.friendSuccess.add(this.canAddFriendSuccess);
        account.triggers.friendFail.add(this.canAddFriendFail);
        account.friend(account.loggedUser.id, this.friend_id);
    }

    @test
    @should_fail
    public function cannotAddAFriendWichDontExist() {
        account.triggers.friendSuccess.add(this.canAddFriendSuccess);
        account.triggers.friendFail.add(this.canAddFriendFail);
        account.friend(this.user_id, 123456789);
    }
    public function canAddFriendSuccess() {}
    public function canAddFriendFail(d: Dynamic) { Assert.fail2(); }

    @test
    public function canRemoveAFriendWichAlreadyExist() {
        account.triggers.unfriendSuccess.add(this.canAddFriendSuccess);
        account.triggers.unfriendFail.add(this.canAddFriendFail);
        account.unfriend(account.getLoggedUser().id, this.friend_id);
    }

    @test
    @should_fail
    public function cannotRemoveAFriendWichDontExist() {
        account.triggers.unfriendSuccess.add(this.canUnFriendSuccess);
        account.triggers.unfriendFail.add(this.canUnFriendFail);
        account.unfriend(this.user_id, 123456789);
    }
    public function canUnFriendSuccess() {}
    public function canUnFriendFail(d: Dynamic) { Assert.fail2(); }

    @test
    public function canBanAnExistingUser() {
        account.triggers.banSuccess.add(this.canBanSuccess);
        account.triggers.banFail.add(this.canBanFail);
        account.ban(this.friend_id);
    }

    @test
    @should_fail
    public function cannotBindANonExistingUser() {
        account.triggers.banSuccess.add(this.canBanSuccess);
        account.triggers.banFail.add(this.canBanFail);
        account.ban(123456789);
    }
    public function canBanSuccess() {}
    public function canBanFail(d: Dynamic) { Assert.fail2(); }

    @test
    public function canLogoutAnUser() {
        account.login({login: "test", password: "test"});
        account.logout();
        Assert.isTrue(account.getLoggedUser() == null);
    }

    @test
    public function canDeleteAnUser() {
        account.deleteUser({id: this.user_id});
        Assert.isNull(account.getUser(this.user_id));
    }
}