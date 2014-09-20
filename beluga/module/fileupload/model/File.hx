package beluga.module.fileupload.model;

// beluga mods
import beluga.module.account.model.User;

// haxe
import sys.db.Object;
import sys.db.Types;

@:id(id)
@:table("beluga_fil_file")
class File extends Object {
    public var id: SId;
    public var owner_id: SInt;
    public var name: SString<32>;
    public var path: SString<32>;
    public var size: SInt;
    @:relation(owner_id)
    public var user: User;
}
