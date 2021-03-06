// Copyright 2014 The Beluga Project Developers. See the LICENCE.md
// file at the top-level directory of this distribution and at
// http://haxebeluga.github.io/licence.html.
//
// Licensed under the MIT License.
// This file may not be copied, modified, or distributed
// except according to those terms.

package beluga.core.macro_tool;

import haxe.macro.Type;

class MacroTools {

    //Returns a human readable full class path (package + className) from a haxe.macro.ClassType
    public static function fullClassPath(classType : ClassType) : String {
        return (classType.pack.length > 0 ? classType.pack.join(".") + "." : "") + classType.name;
    }

}