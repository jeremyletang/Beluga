
package beluga.module.account.api;

import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.core.BelugaException;
import beluga.module.account.Account;
import beluga.module.account.model.User;

class AccountApi 
{
	var beluga : Beluga;
	var account : Account;

	public function new(beluga : Beluga, account : Account) {
		this.beluga = beluga;
		this.account = account;
	}

	//
	//Login
	//

	public function doLogin() {
		//The function should look like something like this:
		//try {			
		//	beluga.triggerDispatcher.dispatch("login")
		//} catch (err : WrongLoginException) {
		//	doDisplayLoginFailPage();
		//} catch (err : WrongPasswordException) {
		//	doDisplayLoginFailPage();		
		//}
		//doDisplayLoginSuccessPage();
	}

	public function doLoginPage() {
        var loginBox : Widget = account.getWidget("login"); //Generic method for all modules
        loginBox.context.login = "Toto"; // For instance, it would fill the username field with Toto
        var subscribeBox : Widget = account.getWidget("subscribe");
        var html : String = loginBox.render() + subscribeBox.render();
        Sys.print(html); 
	}

	//
	//Subscription
	//
	public function doSubscribe(args : { login : String, password : String }) {
		beluga.triggerDispatcher.dispatch("Subscribe");
	}

	public function doSubscribePage() {
        var subscribeBox : Widget = account.getWidget("subscribe");
        var html : String = subscribeBox.render();
        Sys.print(html);
	}

	public function doDefault() {
        trace("Account default page");
	}

}