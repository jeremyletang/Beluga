package beluga.module.ticket.widget;

import beluga.core.Beluga;
import beluga.core.widget.MttWidget;
import beluga.core.macro.ConfigLoader;
import beluga.module.ticket.Ticket;
import beluga.core.BelugaI18n;
import beluga.module.ticket.TicketErrorKind;

class Admin extends MttWidget<TicketImpl> {
    public function new (mttfile = "beluga_ticket_admin.mtt") {
        super(Ticket, mttfile);
        i18n = BelugaI18n.loadI18nFolder("/module/ticket/view/local/admin/", mod.i18n);
    }

    /// Returns the context for the admin widget in the form of a List<Dynamic>
    /// { admin_error: String, labels_list: { label_name: String, label_id: Int } }
    override private function getContext() {
      return {
            error: this.getErrorString(mod.error),
            labels: mod.getLabelsList()
        };
    }

    private function getErrorString(error: TicketErrorKind): String {
        return switch (error) {
            case TicketUserNotLogged: BelugaI18n.getKey(i18n, "user_not_logged");
            case TicketMessageEmpty: BelugaI18n.getKey(i18n, "ticket_message_empty");
            case TicketTitleEmpty: BelugaI18n.getKey(i18n, "ticket_title_empty");
            case TicketUndefinedLabelId: BelugaI18n.getKey(i18n, "undefined_label_id");
            case TicketLabelEmpty: BelugaI18n.getKey(i18n, "ticket_label_empty");
            case TicketLabelAlreadyExist: BelugaI18n.getKey(i18n, "ticket_label_exist");
            case TicketErrorNone: "";
        };
    }
}