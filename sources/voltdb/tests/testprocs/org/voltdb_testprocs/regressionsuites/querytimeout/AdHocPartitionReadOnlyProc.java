/* This file is part of VoltDB.
 * Copyright (C) 2008-2022 Volt Active Data Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

package org.voltdb_testprocs.regressionsuites.querytimeout;

import org.voltdb.SQLStmtAdHocHelper;
import org.voltdb.VoltProcedure;
import org.voltdb.VoltTable;

public class AdHocPartitionReadOnlyProc extends VoltProcedure {
    public String longRunningCrossJoinAgg =
            "SELECT t1.contestant_number, t2.state, COUNT(*) "
            + "FROM P1 t1, R1 t2 "
            + "GROUP BY t1.contestant_number, t2.state;";

    @SuppressWarnings("deprecation")
    public VoltTable[] run() {
        SQLStmtAdHocHelper.voltQueueSQLExperimental(this, longRunningCrossJoinAgg);
        return voltExecuteSQL(true);
    }
}
