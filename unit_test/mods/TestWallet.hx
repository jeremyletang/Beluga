package mods;

import hunit.Assert;
import hunit.AssertException;
import hunit.HUnitTest;

import beluga.core.Beluga;
import beluga.module.wallet.Wallet;
import beluga.module.wallet.WalletErrorKind;

import php.Lib;
import sys.db.Types;

class TestWallet implements HUnitTest {
    public var wallet: Wallet;
    public static var beluga: Beluga;

    public function new() {}

    @before
    public function beforeTest() {
        beluga = Beluga.getInstance();
        wallet = beluga.getModuleInstance(Wallet);
    }

    @test
    public function testCreationSuccessTigger() {
        this.wallet.triggers.creationSuccess.add(this.catchCreationSuccess);
        this.wallet.triggers.creationSuccess.dispatch();
    }
    public function catchCreationSuccess() {}

    @test
    public function testCreationFailTigger() {
        this.wallet.triggers.creationFail.add(this.catchCreationFail);
        this.wallet.triggers.creationFail.dispatch();
    }
    public function catchCreationFail() {}

    @test
    public function testCurrencyCreationSuccessTigger() {
        this.wallet.triggers.currencyCreationSuccess.add(this.catchCurrencyCreationSuccess);
        this.wallet.triggers.currencyCreationSuccess.dispatch();
    }
    public function catchCurrencyCreationSuccess() {}

    @test
    public function testCurrencyCreationFailTigger() {
        this.wallet.triggers.currencyCreationFail.add(this.catchCurrencyCreationFail);
        this.wallet.triggers.currencyCreationFail.dispatch({error: UserNotAuthenticate});
    }
    public function catchCurrencyCreationFail(args: { error : beluga.module.wallet.WalletErrorKind }) {}

    @test
    public function testCurrencyRemoveSuccessTigger() {
        this.wallet.triggers.currencyRemoveSuccess.add(this.catchCurrencyRemoveSuccess);
        this.wallet.triggers.currencyRemoveSuccess.dispatch();
    }
    public function catchCurrencyRemoveSuccess() {}

    @test
    public function testCurrencyRemovenFailTigger() {
        this.wallet.triggers.currencyRemoveFail.add(this.catchCurrencyRemoveFail);
        this.wallet.triggers.currencyRemoveFail.dispatch({error: UserNotAuthenticate});
    }
    public function catchCurrencyRemoveFail(args: { error : beluga.module.wallet.WalletErrorKind }) {}

     @test
    public function testSetSiteCurrencySuccessTigger() {
        this.wallet.triggers.setSiteCurrencySuccess.add(this.catchSetSiteCurrencySuccess);
        this.wallet.triggers.setSiteCurrencySuccess.dispatch();
    }
    public function catchSetSiteCurrencySuccess() {}

    @test
    public function testSetSiteCurrencyFailTigger() {
        this.wallet.triggers.setSiteCurrencyFail.add(this.catchSetSiteCurrencyFail);
        this.wallet.triggers.setSiteCurrencyFail.dispatch();
    }
    public function catchSetSiteCurrencyFail() {}
}
