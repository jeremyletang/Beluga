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

    public function new() {}

    @before_class
    public function beforeClass() {
        beluga = Beluga.getInstance();
        account = beluga.getModuleInstance(Account);
    }

    @after_class
    public function afterClass() {
        beluga.cleanup();
    }

    @before
    public function beforeTest() {}

    @test
    public function canCreateAccount() {
        account.subscribe({login: "test", password: "test", password_conf: "test", email: "test"});
        account.login({login: "test", password: "test"});
        // Sys.print(account.getUsers().length);
        Assert.isTrue(account.getUsers().length >= 1);
    }
}