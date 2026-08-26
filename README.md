# BMMB-852-lmm

laurenmags@Leaftop ~
$ bioinfo
# Activating bioinfo ...
(bioinfo)
laurenmags@Leaftop ~
$ samtools

### Samtools Version & Commands

Program: samtools (Tools for alignments in the SAM format)
Version: 1.24 (using htslib 1.24)

Usage:   samtools <command> [options]

Commands:
  -- Indexing
     dict           create a sequence dictionary file
     faidx          index/extract FASTA
     fqidx          index/extract FASTQ
     index          index alignment

  -- Editing
     calmd          recalculate MD/NM tags and '=' bases
     fixmate        fix mate information
     reheader       replace BAM header
     targetcut      cut fosmid regions (for fosmid pool only)
     addreplacerg   adds or replaces RG tags
     markdup        mark duplicates
     ampliconclip   clip oligos from the end of reads

  -- File operations
     collate        shuffle and group alignments by name
     cat            concatenate BAMs
     consensus      produce a consensus Pileup/FASTA/FASTQ
     merge          merge sorted alignments
     mpileup        multi-way pileup
     sort           sort alignment file
     split          splits a file by read group
     quickcheck     quickly check if SAM/BAM/CRAM file appears intact
     fastq          converts a BAM to a FASTQ
     fasta          converts a BAM to a FASTA
     import         Converts FASTA or FASTQ files to SAM/BAM/CRAM
     reference      Generates a reference from aligned data
     reset          Reverts aligner changes in reads

  -- Statistics
     bedcov         read depth per BED region
     coverage       alignment depth and percent coverage
     depth          compute the depth
     flagstat       simple stats
     idxstats       BAM index stats
     cram-size      list CRAM Content-ID and Data-Series sizes
     phase          phase heterozygotes
     stats          generate stats (former bamcheck)
     ampliconstats  generate amplicon specific stats
     checksum       produce order-agnostic checksums of sequence content

  -- Viewing
     flags          explain BAM flags
     head           header viewer
     tview          text alignment viewer
     view           SAM<->BAM<->CRAM conversion
     depad          convert padded BAM to unpadded BAM
     samples        list the samples in a set of SAM/BAM/CRAM files

  -- Misc
     help [cmd]     display this help message or help for [cmd]
     version        detailed version information

### Commands to Create a Nested Directory Structure


### Basic Unix Commands 

(bioinfo)
laurenmags@Leaftop ~
$ ls --help
List directory contents.
Ignore files and directories starting with a '.' by default

Usage: ls [OPTION]... [FILE]...

Arguments:
  [paths]...

Options:
      --help
          Print help information.
      --format=<format>
          Set the display format.
  -C
          Display the files in columns.
  -l, --long
          Display detailed information.
  -x
          List entries in rows instead of in columns.
  -T, --tabsize <COLS>
          Assume tab stops at each COLS instead of 8 [env: TABSIZE=]
  -m
          List entries separated by commas.
      --zero
          List entries separated by ASCII NUL characters.
  -D, --dired
          generate output designed for Emacs' dired (Directory
          Editor) mode
      --hyperlink[=<WHEN>]
          hyperlink file names WHEN [default: never] [possible
          values: always, auto, never]
  -1
          List one file per line.
  -o
          Long format without group information.
          Identical to --format=long with --no-group.
  -g
          Long format without owner information.
  -n, --numeric-uid-gid
          -l with numeric UIDs and GIDs.
      --quoting-style <quoting-style>
          Set quoting style. [possible values: literal, locale,
          shell, shell-escape, shell-always, shell-escape-always,
          clocale, c, escape]
  -N, --literal
          Use literal quoting style. Equivalent to
          `--quoting-style=literal`
  -b, --escape
          Use escape quoting style. Equivalent to
          `--quoting-style=escape`
  -Q, --quote-name
          Use C quoting style. Equivalent to `--quoting-style=c`
  -q, --hide-control-chars
          Replace control characters with '?' if they are not
          escaped.
      --show-control-chars
          Show control characters 'as is' if they are not escaped.
      --time=<field>
          Show time in `<field>`:
          access time (-u): atime, access, use;
          change time (-t): ctime, status.
          modification time: mtime, modification.
          birth time: birth, creation;
  -c
          If the long listing format (e.g., -l, -o) is being used,
          print the
          status change time (the 'ctime' in the inode) instead of
          the modification
          time. When explicitly sorting by time (--sort=time or -t)
          or when not
          using a long listing format, sort according to the status
          change time.
  -u
          If the long listing format (e.g., -l, -o) is being used,
          print the
          status access time instead of the modification time. When
          explicitly
          sorting by time (--sort=time or -t) or when not using a
          long listing
          format, sort according to the access time.
      --hide <PATTERN>
          do not list implied entries matching shell PATTERN
          (overridden by -a or -A)
  -I, --ignore <PATTERN>
          do not list implied entries matching shell PATTERN
  -B, --ignore-backups
          Ignore entries which end with ~.
      --sort=<field>
          Sort by `<field>`: name, none (-U), time (-t), size (-S),
          extension (-X) or width [possible values: name, none,
          time, size, version, extension, width]
  -S
          Sort by file size, largest first.
  -t
          Sort by modification time (the 'mtime' in the inode),
          newest first.
  -v
          Natural sort of (version) numbers in the filenames.
  -X
          Sort alphabetically by entry extension.
  -U
          Do not sort; list the files in whatever order they are
          stored in the
          directory.  This is especially useful when listing very
          large directories,
          since not doing any sorting can be noticeably faster.
  -L, --dereference
          When showing file information for a symbolic link, show
          information for the
          file the link references rather than the link itself.
      --dereference-command-line-symlink-to-dir
          Do not follow symlinks except when they link to
          directories and are
          given as command line arguments.
  -H, --dereference-command-line
          Do not follow symlinks except when given as command line
          arguments.
  -G, --no-group
          Do not show group in long format.
      --author
          Show author in long format. On the supported platforms,
          the author always matches the file owner.
  -a, --all
          Do not ignore hidden files (files with names that start
          with '.').
  -A, --almost-all
          In a directory, do not ignore all file names that start
          with '.',
          only ignore '.' and '..'.
  -f
          List all files in directory order, unsorted. Equivalent to
          -aU. Disables --color unless explicitly specified.
  -d, --directory
          Only list the names of directories, rather than listing
          directory contents.
          This will not follow symbolic links unless one of
          `--dereference-command-line
          (-H)`, `--dereference (-L)`, or
          `--dereference-command-line-symlink-to-dir` is
          specified.
  -h, --human-readable
          Print human readable file sizes (e.g. 1K 234M 56G).
  -k, --kibibytes
          default to 1024-byte blocks for file system usage; used
          only with -s and per
          directory totals
      --si
          Print human readable file sizes using powers of 1000
          instead of 1024.
      --block-size=<BLOCK_SIZE>
          scale sizes by BLOCK_SIZE when printing them
  -i, --inode
          print the index number of each file
  -r, --reverse
          Reverse whatever the sorting method is e.g., list files in
          reverse
          alphabetical order, youngest first, smallest first, or
          whatever.
  -R, --recursive
          List the contents of all directories recursively.
  -w, --width <COLS>
          Assume that the terminal is COLS columns wide.
  -s, --size
          print the allocated size of each file, in blocks
      --color[=<color>]
          Color output based on file type. [possible values: always,
          auto, never]
      --indicator-style <indicator-style>
          Append indicator with style WORD to entry names:
          none (default),  slash (-p), file-type (--file-type),
          classify (-F) [possible values: none, slash, file-type,
          classify]
  -F, --classify[=<when>]
          Append a character to each file name indicating the file
          type. Also, for
          regular files that are executable, append '*'. The file
          type indicators are
          '/' for directories, '@' for symbolic links, '|' for
          FIFOs, '=' for sockets,
          '>' for doors, and nothing for regular files. when may be
          omitted, or one of:
              none - Do not classify. This is the default.
              auto - Only classify if standard output is a terminal.
              always - Always classify.
          Specifying --classify and no when is equivalent to
          --classify=always. This will
          not follow symbolic links listed on the command line
          unless the
          --dereference-command-line (-H), --dereference (-L), or
          --dereference-command-line-symlink-to-dir options are
          specified. [possible values: always, auto, never]
      --file-type
          Same as --classify, but do not append '*'
  -p
          Append / indicator to directories.
      --time-style <TIME_STYLE>
          time/date format with -l; see TIME_STYLE below [env:
          TIME_STYLE=]
      --full-time
          like -l --time-style=full-iso
  -Z, --context
          print any security context of each file
      --group-directories-first
          group directories before files; can be augmented with
          a --sort option, but any use of --sort=none (-U) disables
          grouping
  -V, --version
          Print version

The TIME_STYLE argument can be full-iso, long-iso, iso, locale or
+FORMAT. FORMAT is interpreted like in date. Also the TIME_STYLE
environment variable sets the default style to use.
(bioinfo)
laurenmags@Leaftop ~
$ cd --help
cd: cd [-L|[-P [-e]]] [-@] [dir]
    Change the shell working directory.

    Change the current directory to DIR.  The default DIR is the value of the
    HOME shell variable. If DIR is "-", it is converted to $OLDPWD.

    The variable CDPATH defines the search path for the directory containing
    DIR.  Alternative directory names in CDPATH are separated by a colon (:).
    A null directory name is the same as the current directory.  If DIR begins
    with a slash (/), then CDPATH is not used.

    If the directory is not found, and the shell option `cdable_vars' is set,
    the word is assumed to be  a variable name.  If that variable has a value,
    its value is used for DIR.

    Options:
      -L        force symbolic links to be followed: resolve symbolic
                links in DIR after processing instances of `..'
      -P        use the physical directory structure without following
                symbolic links: resolve symbolic links in DIR before
                processing instances of `..'
      -e        if the -P option is supplied, and the current working
                directory cannot be determined successfully, exit with
                a non-zero status
      -@        on systems that support it, present a file with extended
                attributes as a directory containing the file attributes

    The default is to follow symbolic links, as if `-L' were specified.
    `..' is processed by removing the immediately previous pathname component
    back to a slash or the beginning of DIR.

    Exit Status:
    Returns 0 if the directory is changed, and if $PWD is set successfully when
    -P is used; non-zero otherwise.
(bioinfo)
laurenmags@Leaftop ~
$ pwd --help
pwd: pwd [-LP]
    Print the name of the current working directory.

    Options:
      -L        print the value of $PWD if it names the current working
                directory
      -P        print the physical directory, without any symbolic links

    By default, `pwd' behaves as if `-L' were specified.

    Exit Status:
    Returns 0 unless an invalid option is given or the current directory
    cannot be read.
(bioinfo)
laurenmags@Leaftop ~
$ mkdir --help
Create the given DIRECTORY(ies) if they do not exist

Usage: mkdir [OPTION]... DIRECTORY...

Arguments:
  <dirs>...

Options:
  -m, --mode <mode>    set file mode (not implemented on windows)
  -p, --parents        make parent directories as needed
  -v, --verbose        print a message for each printed directory
  -Z                   set SELinux security context of each created
                       directory to the default type
      --context <CTX>  like -Z, or if CTX is specified then set the
                       SELinux or SMACK security context to CTX
  -h, --help           Print help
  -V, --version        Print version

Each MODE is of the form
[ugoa]*([-+=]([rwxXst]*|[ugo]))+|[-+=]?[0-7]+.
(bioinfo)
laurenmags@Leaftop ~
$ rm --help
Usage: rm [OPTION]... [FILE]...
Remove (unlink) the FILE(s).

  -f, --force           ignore nonexistent files and arguments, never prompt
  -i                    prompt before every removal
  -I                    prompt once before removing more than three files, or
                          when removing recursively; less intrusive than -i,
                          while still giving protection against most mistakes
      --interactive[=WHEN]  prompt according to WHEN: never, once (-I), or
                          always (-i); without WHEN, prompt always
      --one-file-system  when removing a hierarchy recursively, skip any
                          directory that is on a file system different from
                          that of the corresponding command line argument
      --no-preserve-root  do not treat '/' specially
      --preserve-root[=all]  do not remove '/' (default);
                              with 'all', reject any command line argument
                              on a separate device from its parent
  -r, -R, --recursive   remove directories and their contents recursively
  -d, --dir             remove empty directories
  -v, --verbose         explain what is being done
      --help        display this help and exit
      --version     output version information and exit

By default, rm does not remove directories.  Use the --recursive (-r or -R)
option to remove each listed directory, too, along with all of its contents.

Any attempt to remove a file whose last file name component is '.' or '..'
is rejected with a diagnostic.

To remove a file whose name starts with a '-', for example '-foo',
use one of these commands:
  rm -- -foo

  rm ./-foo

If you use rm to remove a file, it might be possible to recover
some of its contents, given sufficient expertise and/or time.  For greater
assurance that the contents are unrecoverable, consider using shred(1).

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/rm>
or available locally via: info '(coreutils) rm invocation'
(bioinfo)
laurenmags@Leaftop ~
$ mv --help
Usage: mv [OPTION]... [-T] SOURCE DEST
  or:  mv [OPTION]... SOURCE... DIRECTORY
  or:  mv [OPTION]... -t DIRECTORY SOURCE...
Rename SOURCE to DEST, or move SOURCE(s) to DIRECTORY.

Mandatory arguments to long options are mandatory for short options too.
      --backup[=CONTROL]       make a backup of each existing destination file
  -b                           like --backup but does not accept an argument
      --debug                  explain how a file is copied.  Implies -v
      --exchange               exchange source and destination
  -f, --force                  do not prompt before overwriting
  -i, --interactive            prompt before overwrite
  -n, --no-clobber             do not overwrite an existing file
If you specify more than one of -i, -f, -n, only the final one takes effect.
      --no-copy                do not copy if renaming fails
      --strip-trailing-slashes  remove any trailing slashes from each SOURCE
                                 argument
  -S, --suffix=SUFFIX          override the usual backup suffix
  -t, --target-directory=DIRECTORY  move all SOURCE arguments into DIRECTORY
  -T, --no-target-directory    treat DEST as a normal file
      --update[=UPDATE]        control which existing files are updated;
                                 UPDATE={all,none,none-fail,older(default)}
  -u                           equivalent to --update[=older].  See below
  -v, --verbose                explain what is being done
  -Z, --context                set SELinux security context of destination
                                 file to default type
      --help        display this help and exit
      --version     output version information and exit

UPDATE controls which existing files in the destination are replaced.
'all' is the default operation when an --update option is not specified,
and results in all existing files in the destination being replaced.
'none' is like the --no-clobber option, in that no files in the
destination are replaced, and skipped files do not induce a failure.
'none-fail' also ensures no files are replaced in the destination,
but any skipped files are diagnosed and induce a failure.
'older' is the default operation when --update is specified, and results
in files being replaced if they're older than the corresponding source file.

The backup suffix is '~', unless set with --suffix or SIMPLE_BACKUP_SUFFIX.
The version control method may be selected via the --backup option or through
the VERSION_CONTROL environment variable.  Here are the values:

  none, off       never make backups (even if --backup is given)
  numbered, t     make numbered backups
  existing, nil   numbered if numbered backups exist, simple otherwise
  simple, never   always make simple backups

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/mv>
or available locally via: info '(coreutils) mv invocation'
(bioinfo)
laurenmags@Leaftop ~
$ cp --help
Usage: cp [OPTION]... [-T] SOURCE DEST
  or:  cp [OPTION]... SOURCE... DIRECTORY
  or:  cp [OPTION]... -t DIRECTORY SOURCE...
Copy SOURCE to DEST, or multiple SOURCE(s) to DIRECTORY.

Mandatory arguments to long options are mandatory for short options too.
  -a, --archive                same as -dR --preserve=all
      --attributes-only        don't copy the file data, just the attributes
      --backup[=CONTROL]       make a backup of each existing destination file
  -b                           like --backup but does not accept an argument
      --copy-contents          copy contents of special files when recursive
  -d                           same as --no-dereference --preserve=links
      --debug                  explain how a file is copied.  Implies -v
  -f, --force                  if an existing destination file cannot be
                                 opened, remove it and try again (this option
                                 is ignored when the -n option is also used)
  -i, --interactive            prompt before overwrite (overrides a previous -n
                                  option)
  -H                           follow command-line symbolic links in SOURCE
  -l, --link                   hard link files instead of copying
  -L, --dereference            always follow symbolic links in SOURCE
  -n, --no-clobber             (deprecated) do not overwrite an existing file
                                 and do not fail
 (overrides a -u or
                                 previous -i option). See also --update;
                                 equivalent to --update=none.
  -P, --no-dereference         never follow symbolic links in SOURCE
  -p                           same as --preserve=mode,ownership,timestamps
      --preserve[=ATTR_LIST]   preserve the specified attributes
      --no-preserve=ATTR_LIST  don't preserve the specified attributes
      --parents                use full source file name under DIRECTORY
  -R, -r, --recursive          copy directories recursively
      --reflink[=WHEN]         control clone/CoW copies. See below
      --remove-destination     remove each existing destination file before
                                 attempting to open it (contrast with --force)
      --sparse=WHEN            control creation of sparse files. See below
      --strip-trailing-slashes  remove any trailing slashes from each SOURCE
                                 argument
  -s, --symbolic-link          make symbolic links instead of copying
  -S, --suffix=SUFFIX          override the usual backup suffix
  -t, --target-directory=DIRECTORY  copy all SOURCE arguments into DIRECTORY
  -T, --no-target-directory    treat DEST as a normal file
      --update[=UPDATE]        control which existing files are updated;
                                 UPDATE={all,none,none-fail,older(default)}
  -u                           equivalent to --update[=older].  See below
  -v, --verbose                explain what is being done
      --keep-directory-symlink  follow existing symlinks to directories
  -x, --one-file-system        stay on this file system
  -Z                           set SELinux security context of destination
                                 file to default type
      --context[=CTX]          like -Z, or if CTX is specified then set the
                                 SELinux or SMACK security context to CTX
      --help        display this help and exit
      --version     output version information and exit

ATTR_LIST is a comma-separated list of attributes. Attributes are 'mode' for
permissions (including any ACL and xattr permissions), 'ownership' for user
and group, 'timestamps' for file timestamps, 'links' for hard links, 'context'
for security context, 'xattr' for extended attributes, and 'all' for all
attributes.

By default, sparse SOURCE files are detected by a crude heuristic and the
corresponding DEST file is made sparse as well.  That is the behavior
selected by --sparse=auto.  Specify --sparse=always to create a sparse DEST
file whenever the SOURCE file contains a long enough sequence of zero bytes.
Use --sparse=never to inhibit creation of sparse files.

UPDATE controls which existing files in the destination are replaced.
'all' is the default operation when an --update option is not specified,
and results in all existing files in the destination being replaced.
'none' is like the --no-clobber option, in that no files in the
destination are replaced, and skipped files do not induce a failure.
'none-fail' also ensures no files are replaced in the destination,
but any skipped files are diagnosed and induce a failure.
'older' is the default operation when --update is specified, and results
in files being replaced if they're older than the corresponding source file.

When --reflink[=always] is specified, perform a lightweight copy, where the
data blocks are copied only when modified.  If this is not possible the copy
fails, or if --reflink=auto is specified, fall back to a standard copy.
Use --reflink=never to ensure a standard copy is performed.

The backup suffix is '~', unless set with --suffix or SIMPLE_BACKUP_SUFFIX.
The version control method may be selected via the --backup option or through
the VERSION_CONTROL environment variable.  Here are the values:

  none, off       never make backups (even if --backup is given)
  numbered, t     make numbered backups
  existing, nil   numbered if numbered backups exist, simple otherwise
  simple, never   always make simple backups

As a special case, cp makes a backup of SOURCE when the force and backup
options are given and SOURCE and DEST are the same name for an existing,
regular file.

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/cp>
or available locally via: info '(coreutils) cp invocation'
(bioinfo)
laurenmags@Leaftop ~
$ ln --help
Make links between files.

Usage: ln [OPTION]... [-T] TARGET LINK_NAME
       ln [OPTION]... TARGET
       ln [OPTION]... TARGET... DIRECTORY
       ln [OPTION]... -t DIRECTORY TARGET...

Arguments:
  <files>...

Options:
      --backup[=<CONTROL>]
          make a backup of each existing destination file
  -b
          like --backup but does not accept an argument
  -f, --force
          remove existing destination files
  -i, --interactive
          prompt whether to remove existing destination files
  -n, --no-dereference
          treat LINK_NAME as a normal file if it is a
          symbolic link to a directory
  -L, --logical
          follow TARGETs that are symbolic links
  -P, --physical
          make hard links directly to symbolic links
  -s, --symbolic
          make symbolic links instead of hard links
  -S, --suffix <SUFFIX>
          override the usual backup suffix
  -t, --target-directory <DIRECTORY>
          specify the DIRECTORY in which to create the links
  -T, --no-target-directory
          treat LINK_NAME as a normal file always
  -r, --relative
          create symbolic links relative to link location
  -v, --verbose
          print name of each linked file
  -h, --help
          Print help
  -V, --version
          Print version

In the 1st form, create a link to TARGET with the name LINK_NAME.
In the 2nd form, create a link to TARGET in the current directory.
In the 3rd and 4th forms, create links to each TARGET in DIRECTORY.
Create hard links by default, symbolic links with --symbolic.
By default, each destination (name of new link) should not already
exist.
When creating hard links, each TARGET must exist. Symbolic links
can hold arbitrary text; if later resolved, a relative link is
interpreted in relation to its parent directory.

The backup suffix is '~', unless set with --suffix or
SIMPLE_BACKUP_SUFFIX.
The version control method may be selected via the --backup option
or through
the VERSION_CONTROL environment variable.  Here are the values:

  none, off       never make backups (even if --backup is given)
  numbered, t     make numbered backups
  existing, nil   numbered if numbered backups exist, simple
  otherwise
  simple, never   always make simple backups
(bioinfo)
laurenmags@Leaftop ~
$ head --help
Print the first 10 lines of each FILE to standard output.
With more than one FILE, precede each with a header giving the file
name.
With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long flags are mandatory for short flags too.

Usage: head [FLAG]... [FILE]...

Arguments:
  [FILE]...

Options:
  -c, --bytes <[-]NUM>   print the first NUM bytes of each file;
                         with a leading '-', print all but the last
                         NUM bytes of each file
  -n, --lines <[-]NUM>   print the first NUM lines instead of the
                         first 10;
                         with a leading '-', print all but the last
                         NUM lines of each file
  -q, --quiet            never print headers giving file names
                         [aliases: --silent]
  -v, --verbose          always print headers giving file names
  -z, --zero-terminated  line delimiter is NUL, not newline
  -h, --help             Print help
  -V, --version          Print version
(bioinfo)
laurenmags@Leaftop ~
$ tail --help
Print the last 10 lines of each FILE to standard output.
With more than one FILE, precede each with a header giving the file
name.
With no FILE, or when FILE is -, read standard input.
Mandatory arguments to long flags are mandatory for short flags too.

Usage: tail [FLAG]... [FILE]...

Arguments:
  [files]...

Options:
  -c, --bytes <bytes>
          Number of bytes to print
  -f, --follow[=<follow>]
          Print the file as it grows [possible values: descriptor,
          name]
  -n, --lines <lines>
          Number of lines to print
      --pid <PID>
          With -f, terminate after process ID, PID dies
  -q, --quiet
          Never output headers giving file names [aliases: --silent]
  -s, --sleep-interval <N>
          Number of seconds to sleep between polling the file when
          running with -f
      --max-unchanged-stats <N>
          Reopen a FILE which has not changed size after N (default
          5) iterations to see if it has been unlinked or renamed
          (this is the usual case of rotated log files); This option
          is meaningful only when polling (i.e., with --use-polling)
          and when --follow=name
  -v, --verbose
          Always output headers giving file names
  -z, --zero-terminated
          Line delimiter is NUL, not newline
      --use-polling
          Disable 'inotify' support and use polling instead
      --retry
          Keep trying to open a file if it is inaccessible
  -F
          Same as --follow=name --retry
      --debug
          indicate which --follow implementation is used
  -h, --help
          Print help
  -V, --version
          Print version
(bioinfo)
laurenmags@Leaftop ~
$ more --help

Usage:
 more [options] <file>...

Display the contents of a file in a terminal.

Options:
 -d, --silent          display help instead of ringing bell
 -f, --logical         count logical rather than screen lines
 -l, --no-pause        suppress pause after form feed
 -c, --print-over      do not scroll, display text and clean line ends
 -p, --clean-print     do not scroll, clean screen and display text
 -e, --exit-on-eof     exit on end-of-file
 -s, --squeeze         squeeze multiple blank lines into one
 -u, --plain           suppress underlining and bold
 -n, --lines <number>  the number of lines per screenful
 -<number>             same as --lines
 +<number>             display file beginning from line number
 +/<pattern>           display file beginning from pattern match

 -h, --help            display this help
 -V, --version         display version

For more details see more(1).
(bioinfo)
laurenmags@Leaftop ~
$
