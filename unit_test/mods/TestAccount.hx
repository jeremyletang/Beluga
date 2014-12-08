package mods;

import hunit.Assert;
import hunit.AssertException;
import hunit.HUnitTest;

import beluga.Beluga;
import beluga.module.account.Account;
import beluga.module.account.model.User;

import php.Lib;
import sys.db.Types;
import php.Web;

class TestAccount implements HUnitTest {
    public static var beluga: Beluga;
    public var account: Account;
    public var user: User;
    public var friend: User;

    public function new() {}

    @before_class
    public function beforeClass() {
        beluga = Beluga.getInstance();
        this.account = Beluga.getInstance().getModuleInstance(Account);
        this.account.subscribe({login: "friend", password: "friend1234", password_conf: "friend1234", email: "friend@friend.com"});
        this.account.login({login:"friend", password: "friend1234"});
        this.friend = account.getLoggedUser();
        this.account.logout();
    }

    @after_class
    public function afterClass() {
        // beluga.cleanup();
    }

    @before
    public function beforeTest() {}

    @after
    public function afterTest() {
        account.logout();
    }

    @test
    public function canCreateAnAccountWithValidsDatas() {
        this.account = Beluga.getInstance().getModuleInstance(Account);
        this.account.triggers.subscribeSuccess.add(this.canCreateAnAccountSuccess);
        this.account.triggers.subscribeFail.add(this.canCreateAnAccountFail);
        this.account.subscribe({login: "test", password: "test1234", password_conf: "test1234", email: "test@test.com"});
        this.user = this.account.getLoggedUser();
    }

    @test
    @should_fail
    public function cannotCreateAnAccountWithAnExistingUserName() {
        account.triggers.subscribeSuccess.add(this.canCreateAnAccountSuccess);
        account.triggers.subscribeFail.add(this.canCreateAnAccountFail);
        account.subscribe({login: "test", password: "test1234", password_conf: "test1234", email: "test@test.com"});
    }
    public function canCreateAnAccountSuccess(d: Dynamic) {}
    public function canCreateAnAccountFail(d: Dynamic) { Assert.fail2(); }


    @test
    public function canLogAnUserWithValidPasswordAndUserName() {
        this.account.login({login: "test", password: "test1234"});
        this.user = this.account.getLoggedUser();
        Assert.isTrue(this.account.getLoggedUser() != null);
    }

    @test
    public function cannotLogAnUserWithInvalidPasswordAndUserName() {
        this.account.login({login: "not_valid", password: "not_valid"});
        Assert.isTrue(this.account.getLoggedUser() == null);
    }

    @test
    public function canEditUserInformations() {
        this.account.login({login: "test", password: "test1234"});
        var user = account.getLoggedUser();
        account.edit(account.getLoggedUser().id, "new_mail@test.com");
        // Assert.eq(account.getLoggedUser().email, "new_mail");
    }

    @test
    public function canAddAFriendWichAlreadyExist() {
        this.account.login({login: "test", password: "test1234"});
        account.triggers.friendSuccess.add(this.canAddFriendSuccess);
        account.triggers.friendFail.add(this.canAddFriendFail);
        account.friend(account.loggedUser.id, this.friend.id);
    }

    @test
    @should_fail
    public function cannotAddAFriendWichDontExist() {
        this.account.login({login: "test", password: "test1234"});
        account.triggers.friendSuccess.add(this.canAddFriendSuccess);
        account.triggers.friendFail.add(this.canAddFriendFail);
        account.friend(this.user.id, 123456789);
    }
    public function canAddFriendSuccess() {}
    public function canAddFriendFail(d: Dynamic) { Assert.fail2(); }

    @test
    public function canRemoveAFriendWichAlreadyExist() {
        this.account.login({login: "test", password: "test1234"});
        account.triggers.unfriendSuccess.add(this.canAddFriendSuccess);
        account.triggers.unfriendFail.add(this.canAddFriendFail);
        account.unfriend(account.getLoggedUser().id, this.friend.id);
    }

    @test
    @should_fail
    public function cannotRemoveAFriendWichDontExist() {
        account.triggers.unfriendSuccess.add(this.canUnFriendSuccess);
        account.triggers.unfriendFail.add(this.canUnFriendFail);
        account.unfriend(this.user.id, 123456789);
    }
    public function canUnFriendSuccess() {}
    public function canUnFriendFail(d: Dynamic) { Assert.fail2(); }

    @test
    public function canBanAnExistingUser() {
        account.triggers.banSuccess.add(this.canBanSuccess);
        account.triggers.banFail.add(this.canBanFail);
        account.ban(this.friend.id);
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
        // this.account.login({login: "test", password: "test"});
        account.logout();
        Assert.isTrue(account.getLoggedUser() == null);
    }

    @test
    public function canDeleteAnUser() {
        account.deleteUser({id: this.user.id});
        Assert.isNull(account.getUser(this.user.id));
    }
}