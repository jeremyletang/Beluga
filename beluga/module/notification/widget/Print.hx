package beluga.module.notification.widget;

import beluga.core.Beluga;
import beluga.core.widget.MttWidget;
import beluga.core.macro.ConfigLoader;
import beluga.core.BelugaI18n;

import beluga.module.notification.Notification;
import beluga.module.notification.NotificationErrorKind;
import beluga.module.account.Account;
import beluga.core.ResourceManager;
import beluga.core.ResourceManager;

class Print extends MttWidget<Notification> {

    public function new (?mttfile : String) {
        if(mttfile == null) mttfile = ResourceManager.getString("/module/notification/view/tpl/print_notif.mtt");
        super(mttfile);
        i18n = BelugaI18n.loadI18nFolder("/module/notification/view/locale/print/", mod.i18n);
    }

    override private function getContext() : Dynamic {
        if (mod.canPrint(mod.actual_notif_id)) {
            var user = Beluga.getInstance().getModuleInstance(Account).loggedUser;

            return {
                notif : mod.getNotification(mod.actual_notif_id, user.id),
                path : "/beluga/notification/"
            };
        }
        var ret = mod.widgets.notification.getContext();

        ret.other = mod.widgets.notification.render();
        return ret;
    }
}