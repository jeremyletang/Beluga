// Copyright 2014 The Beluga Project Developers. See the LICENCE.md
// file at the top-level directory of this distribution and at
// http://haxebeluga.github.io/licence.html.
//
// Licensed under the MIT License.
// This file may not be copied, modified, or distributed
// except according to those terms.

package beluga.module.ticket.widget;

import beluga.core.Beluga;
import beluga.core.widget.MttWidget;
import beluga.core.macro.ConfigLoader;
import beluga.module.ticket.Ticket;
import beluga.core.BelugaI18n;

class Create extends MttWidget<TicketImpl> {

    public function new (mttfile = "beluga_ticket_create.mtt") {
        super(Ticket, mttfile);
        i18n = BelugaI18n.loadI18nFolder("/module/ticket/view/local/create/", mod.i18n);
    }

    override private function getContext(): Dynamic {
        return mod.getCreateContext();
    }
}