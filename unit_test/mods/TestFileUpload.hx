package mods;

import hunit.Assert;
import hunit.AssertException;
import hunit.HUnitTest;

import beluga.Beluga;
import beluga.module.fileupload.Fileupload;
import beluga.module.fileupload.FileUploadErrorKind;

import php.Lib;
import sys.db.Types;


class TestFileUpload implements HUnitTest {
    public var file_upload: Fileupload;
    public static var beluga: Beluga;

    public function new() {}

    @before_class
    public function beforeClass() {
        beluga = Beluga.getInstance();
        file_upload = beluga.getModuleInstance(Fileupload);
    }

    @after_class
    public function afterClass() {
        // beluga.cleanup();
    }

    @test
    public function testSendTrigger() {
        this.file_upload.triggers.send.add(this.catchSend);
        this.file_upload.triggers.send.dispatch();
    }
    public function catchSend() {}

    @test
    public function testDeleteTrigger() {
        this.file_upload.triggers.delete.add(this.catchDelete);
        this.file_upload.triggers.delete.dispatch({id: 1});
    }
    public function catchDelete(args: {id: Int}) {
        Assert.eq(args.id, 1);
    }

    @test
    public function testDeleteFailTrigger() {
        this.file_upload.triggers.deleteFail.add(this.catchDeleteFail);
        this.file_upload.triggers.deleteFail.dispatch({ error : FileUploadUserNotLogged });
    }
    public function catchDeleteFail(args: { error : beluga.module.fileupload.FileUploadErrorKind }) {
        // Assert.eq(args.reason, "err");
    }

    @test
    public function testDeleteSuccessTrigger() {
        this.file_upload.triggers.deleteSuccess.add(this.catchDeleteSuccess);
        this.file_upload.triggers.deleteSuccess.dispatch();
    }
    public function catchDeleteSuccess() {}

    @test
    public function testUploadFailTrigger() {
        this.file_upload.triggers.uploadFail.add(this.catchUploadFail);
        this.file_upload.triggers.uploadFail.dispatch({ error : FileUploadUserNotLogged });
    }
    public function catchUploadFail(args: { error : beluga.module.fileupload.FileUploadErrorKind }) {
        // Assert.eq(args.reason, "err");
    }

    @test
    public function testUploadSuccessTrigger() {
        this.file_upload.triggers.uploadSuccess.add(this.catchUploadSuccess);
        this.file_upload.triggers.uploadSuccess.dispatch();
    }
    public function catchUploadSuccess() {
        // Assert.eq(args.title, "title");
        // Assert.eq(args.text, "text");
        // Assert.eq(args.user_id, 1);
    }

    @test
    public function testAddExtensionSuccessTrigger() {
        this.file_upload.triggers.addExtensionSuccess.add(this.catchAddExtensionSuccess);
        this.file_upload.triggers.addExtensionSuccess.dispatch();
    }
    public function catchAddExtensionSuccess() {}

    @test
    public function testAddExtensionFailTrigger() {
        this.file_upload.triggers.addExtensionFail.add(this.catchAddExtensionFail);
        this.file_upload.triggers.addExtensionFail.dispatch({ error : FileUploadUserNotLogged });
    }
    public function catchAddExtensionFail(args: { error : beluga.module.fileupload.FileUploadErrorKind }) {}

    @test
    public function testDeleteExtensionSuccessTrigger() {
        this.file_upload.triggers.deleteExtensionSuccess.add(this.catchDeleteExtensionSuccess);
        this.file_upload.triggers.deleteExtensionSuccess.dispatch();
    }
    public function catchDeleteExtensionSuccess() {}

    @test
    public function testDeleteExtensionFailTrigger() {
        this.file_upload.triggers.deleteExtensionFail.add(this.catchDeleteExtensionFail);
        this.file_upload.triggers.deleteExtensionFail.dispatch({ error : FileUploadUserNotLogged });
    }
    public function catchDeleteExtensionFail(args: { error : beluga.module.fileupload.FileUploadErrorKind }) {}
}