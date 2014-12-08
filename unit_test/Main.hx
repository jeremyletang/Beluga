package ;

import hunit.HUnitTestRunner;

import beluga.Beluga;
import beluga.module.account.Account;

import mods.TestAccount;

class Main {
    public static var beluga: Beluga;

    static function main() {
        beluga = Beluga.getInstance(sys.db.Mysql.connect({
            host : "127.0.0.1",
            port : 8889,
            user : "root",
            pass : "root",
            database : "beluga_tu",
            socket : null,
        }));
        new HUnitTestRunner().run();
    }
}
