package mods;

import hunit.Assert;
import hunit.AssertException;
import hunit.HUnitTest;

import beluga.core.Beluga;
import beluga.module.ticket.Ticket;
import beluga.module.account.Account;

import php.Lib;
import sys.db.Types;

class TestTicket implements HUnitTest {
    public var ticket: Ticket;
    public var account: Account;
    public static var beluga: Beluga;
    public var ticket_id: Int;

    public function new() {}

    @before_class
    public function beforeClass() {
        beluga = Beluga.getInstance();
        ticket = beluga.getModuleInstance(Ticket);
        account = beluga.getModuleInstance(Account);
        account.subscribe({login: "test", password: "test", password_conf: "test", email: "test"});
        account.login({login: "test", password: "test"});
    }

    @after_class
    public function afterClass() {
        var user_id = {id: account.loggedUser.id};
        account.logout();
        account.deleteUser(user_id);
        beluga.cleanup();
    }

    @before
    public function beforeTest() {
        ticket = beluga.getModuleInstance(Ticket);
    }

    @test
    public function canSubmitANewTicketWithAllValidDatas() {
        ticket.triggers.show.add(this.submitTicketSuccess);
        // ticket.triggers.create.add(this.submitTicketFail);
        ticket.submit({ title: "new_ticket", message: "msg", assignee: "test" });
    }

    // @test
    // @should_fail
    // public function cannotSubmitANewTicketWithMissingDatas() {
    //     ticket.triggers.show.add(this.submitTicketSuccess);
    //     // ticket.triggers.create.add(this.submitTicketFail);
    //     ticket.submit({ title: "", message: "", assignee: "" });
    // }
    public function submitTicketSuccess() { this.ticket_id = ticket.show_id; }
    // public function submitTicketFail() { Assert.fail2(); }

    @test
    public function canAddALabel() {
        ticket.triggers.addLabelSuccess.add(this.canAddLabelSuccess);
        // ticket.triggers.addLabelFail.add(this.canAddLabelFail);
        ticket.addlabel({name: "new_label"});
    }
    public function canAddLabelSuccess() {}
    // public function canAddLabelFail() { Assert.fail2(); }

    @test
    public function testBrowseTrigger() {
        this.ticket.triggers.browse.add(this.catchShow);
        this.ticket.triggers.browse.dispatch();
    }
    public function catchBrowse() {}

    @test
    public function testShowTrigger() {
        this.ticket.triggers.show.add(this.catchShow);
        this.ticket.triggers.show.dispatch();
    }
    public function catchShow() {}

    @test
    public function testAdminTrigger() {
        this.ticket.triggers.admin.add(this.catchAdmin);
        this.ticket.triggers.admin.dispatch();
    }
    public function catchAdmin() {}

    @test
    public function testDeleteLabelFailTrigger() {
        this.ticket.triggers.deleteLabelFail.add(this.catchDeleteLabelFail);
        this.ticket.triggers.deleteLabelFail.dispatch();
    }
    public function catchDeleteLabelFail() {}

    @test
    public function testDeleteLabelSuccessTrigger() {
        this.ticket.triggers.deleteLabelSuccess.add(this.catchDeleteLabelSuccess);
        this.ticket.triggers.deleteLabelSuccess.dispatch();
    }
    public function catchDeleteLabelSuccess() {}

    @test
    public function testAddLabelFailTrigger() {
        this.ticket.triggers.addLabelFail.add(this.catchAddLabelFail);
        this.ticket.triggers.addLabelFail.dispatch();
    }
    public function catchAddLabelFail() {}

    @test
    public function testAddLabelSuccessTrigger() {
        this.ticket.triggers.addLabelSuccess.add(this.catchAddLabelSuccess);
        this.ticket.triggers.addLabelSuccess.dispatch();
    }
    public function catchAddLabelSuccess() {}

    @test
    public function testAssignNotifyTrigger() {
        this.ticket.triggers.assignNotify.add(this.catchAssignNotify);
        this.ticket.triggers.assignNotify.dispatch({title: "Ticket", text: "Txt", user_id: 1});
    }
    public function catchAssignNotify(args: {title: String, text: String, user_id: SId}) {
        Assert.eq(args.title, "Ticket");
        Assert.eq(args.text, "Txt");
        Assert.eq(args.user_id, 1);
    }
}
