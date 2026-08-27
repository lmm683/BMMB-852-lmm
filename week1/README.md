# Week 1 Assignment - Demonstrating Basic Unix Commands

### Samtools Version

Before using the 'samtools' command, you must first activate the bioinfo environment by typing 'bioinfo'

Then, when you type 'samtools' into the terminal, a large response will pop up containing the samtools program version followed by a long list of commands

My samtools version shows up as follows:
```bash
    Program: samtools (Tools for alignments in the SAM format)
    Version: 1.24 (using htslib 1.24)
```

## Commands Needed to Create A Nested Directory

Start by listing your directories using the 'ls' command. This will display itself as such:
```bash
    laurenmags@Leaftop ~
    $ ls
    edirect  edu  snap  snpcall.2026.mk  work
```
As you can see, my directories currently consist of edirect, edu, snap, snpcall.2026.mk, and work. We are mainly going to be focusing on the 'work' directory. 

Next, change your directory using the 'cd' command. I am going to change my directory to 'work' Here is how this is entered:
```bash
    laurenmags@Leaftop ~
    $ cd work/
    
    laurenmags@Leaftop ~/work
    $
```
Notice how the new directory is shown next to the user on the next line after switching the directory. This helps the user keep track of where they are working. 

Next, since this is week one, we are going to make a new directory underneath the 'work' directory:
```bash
    laurenmags@Leaftop ~/work
    $ mkdir week1
```
Now when we do the ls command (within the 'work' directory!) the directories within the 'work' directory will be displayed, including our new 'week1' directory
```bash
    laurenmags@Leaftop ~/work
    $ ls
    snpcall  week1
```
Now we have created a directory within a directory! 

## Creating and Manipulating a File

Using the same steps shown before, we are going to move into the week1 directory:
```bash
    laurenmags@Leaftop ~/work
    $ cd week1
    
    laurenmags@Leaftop ~/work/week1
    $
```

Now, we are going to create a file two different ways. First, we are going to create an empty file using the 'touch' command:
```bash
    laurenmags@Leaftop ~/work/week1
    $ touch test.txt
```
You can confirm that the file has been created with the 'ls' command

Second, the other way to create a file is by directly putting information into a new file. I will demonstrate this with the 'date' command. The 'date' command typically outputs the date, pretty intuitive, but as you will see with the '>' tool, the output will be dumped into the created file:
```bash
    laurenmags@Leaftop ~/work/week1
    $ date > date.txt
```
You can read this file by using the 'head' command
```bash
    laurenmags@Leaftop ~/work/week1
    $ head date.txt
    Thu Aug 27 13:08:16 EDT 2026
```



