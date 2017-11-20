/*
    This file is part of Sambamba.
    Copyright (C) 2017 Pjotr Prins <pjotr.prins@thebird.nl>

    Sambamba is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Sambamba is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

*/
module sambamba.markdup2;

/**

   Markdup2 is a new version of sambamba markdup (under development).

   The new version is a prototype for new sambamba architecture using
   canonical D language features, including immutable and improved
   laziness and a more functional programming style. It should provide
   improved performance and minimize RAM use, as well as better
   composability. Also we are preparing it for CRAM input.

   The initial version is a large data markdup which was previously invoked as

     sambamba markdup --hash-table-size=2097152 --overflow-list-size=160000 --io-buffer-size=1024 in.bam out.bam

   Authors: Pjotr Prins

 */

import std.stdio;
import std.getopt;

import sambamba.bam.reader;

void printUsage() {
  writeln("
Usage: sambamba markdup2 [options] <input.bam> [<input2.bam> [...]]

       By default, marks duplicates without removing them.
       Writes to stdout if no output file is given.

Options: -r, --remove-duplicates   remove duplicates instead of just marking them (nyi)
         -o, --output-filename fn  write to output file (bam format) (nyi)
");
}

void info(string msg) {
  stderr.writeln("INFO: ",msg);
}

int markdup_main(string[] args) {
  bool remove_duplicates;
  string outfn;
  getopt(args,
         std.getopt.config.caseSensitive,
         "remove-duplicates|r", &remove_duplicates,
         "output-filename|o", &outfn);

  if (args.length < 2) {
    printUsage();
    return 1;
  }

  info("Reading input files");

  auto infns = args[1..$];
  writeln(infns);

  // let's start simple with one Bam file
  auto R = Reader(infns[0]);
  foreach (int rd; R) {
    writeln(rd);
  }
  return 0;
}
