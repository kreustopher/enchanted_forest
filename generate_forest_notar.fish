# now edits:
# "poor guy" and lightning/fire trees, check if modifiers are gay
# currently this is only using these files:
# ./ascii_art_useme
# ./csvs

# » cat « 
# The language lol
# commands = incantations
# flags/options = inflections
# args = offerings
# stdin/stdout = input/output
# pipes = bridge
# alternatively, thinking of using offerings as stdin and fruit as stdout, so you can use the fruit of one incantation as an offering to another.
# Option 1: Introduce it early, explicitly. Cat's first lesson is ls ./tree or similar. Cat can just say it: "See that thing at the end? That's your offering. You're offering the spell a thing to act on. Everything you point me at is an offering." Done. Term planted. Never has to be re-explained.


# Rename to _id_, then at the end, shuffle everything and rename to 1_tree, 2_bush, 3_bear, etc.
# Lightning chance: 1%
# Fire chance: 3%

set delete_da_portal_or_nah yes
if test -d ./portal
    set delete_da_portal_or_nah
    echo "There's already a 'portal' directory in ./ (that is, ./portal). 

    Listen and lock in: if you're running this for the first time, do NOT simply say 'yes'. Put this game somewhere else instead. Maybe be normal? Maybe put it in its own directory?

    Anyway, type 'yes' and hit [Enter] if you want to remove the 'portal' directory and put the game in there.
    "
    read delete_da_portal_or_nah
end

if test $delete_da_portal_or_nah = yes
    rm -rf ./portal
else
    exit
end

#mkdir ./forest
mkdir -p ./portal/forest

## tar stuff {{{
#fusermount -u ./portal
#mkdir ./portal
#rm portal.tar
## }}}

# make forest {{{
# clear globals {{{
set tree_items
set branch_items
set modifier_items
set bush_items
set ground_items

set trees_csv
set trees_fire_csv
set trees_lightning_csv
set trees_modifiers_csv

set tree_items_len
set branch_items_len
set modifier_items_len
set bush_items_len
set ground_items_len

set trees_len
set trees_fire_len
set trees_lightning_len
set trees_modifiers_len

set cur_line
set cur_ground_line
# }}}

set how_many_trees_n_things 500

set tree_items ./csvs/tree_items.csv
set branch_items ./csvs/branch_items.csv
set modifier_items ./csvs/modifier_items.csv
set bush_items ./csvs/bush_items.csv
set ground_items ./csvs/ground_items.csv

set trees_csv ./csvs/trees_and_itemids.csv
set trees_fire_csv ./csvs/trees_fire_and_itemids.csv
set trees_lightning_csv ./csvs/trees_lightning_and_itemids.csv
set trees_modifiers_csv ./csvs/trees_modifiers_and_itemids.csv

set tree_items_len $(wc -l $tree_items|awk '{print $1}')
set branch_items_len $(wc -l $branch_items|awk '{print $1}')
set modifier_items_len $(wc -l $modifier_items|awk '{print $1}')
set bush_items_len $(wc -l $bush_items|awk '{print $1}')
set ground_items_len $(wc -l $ground_items|awk '{print $1}')

set trees_len $(wc -l $trees_csv|awk '{print $1}')
set trees_fire_len $(wc -l $trees_fire_csv|awk '{print $1}')
set trees_lightning_len $(wc -l $trees_lightning_csv|awk '{print $1}')
set trees_modifiers_len $(wc -l $trees_modifiers_csv|awk '{print $1}')

# Generate the forest (trees, bushes later because I forgor)
for current_tree_num in $(seq 1 $how_many_trees_n_things) # how many trees you want to generate

    # first, populate a ground item
    set cur_ground_line $(sed -n $(random 2 $ground_items_len)p $ground_items|sed 's/"$//'|sed 's/^"//'|string split '","')
    echo $cur_ground_line[3] > ./portal/forest/$cur_ground_line[2]_$current_tree_num.txt



    echo working on tree/item $current_tree_num of $how_many_trees_n_things

    set cur_line
    set cur_type
    set cur_stage
    set cur_sensory
    set cur_minbranch
    set cur_maxbranch
    set cur_items
    set cur_branch_items
    set cur_modifiers
    set cur_directory
    set cur_modifiers_items
    set cur_modifiers_items_count

    set cur_items_count
    set cur_branch_items_count
    set cur_modifiers_items_len
    set cur_modifiers_items_count

    set cur_item
    set cur_item_id
    set cur_branch_item
    set cur_branch_item_id
    set cur_modifier
    set cur_modifier_item
    set cur_modifier_item_id

    set cur_branches

    set random_val $(random 1 100)
    if contains -- $random_val 1 ; or contains -- $current_tree_num 69 # lightning
        set cur_line $(sed -n $(random 2 $trees_lightning_len)p $trees_lightning_csv|sed 's/"$//'|sed 's/^"//')
        if test $current_tree_num = 69
            set cur_line $(grep 'oak.*lightning_aged' $trees_lightning_csv|sed 's/"$//'|sed 's/^"//')
        end
    else if contains -- $random_val 2 3 4 5 6 # fire
        set cur_line $(sed -n $(random 2 $trees_fire_len)p $trees_fire_csv|sed 's/"$//'|sed 's/^"//')
    else if contains -- $random_val 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 26 27 28 # modifiers
        set cur_line $(sed -n $(random 2 $trees_modifiers_len)p $trees_modifiers_csv|sed 's/"$//'|sed 's/^"//')
        set cur_modifiers $(echo $cur_line | awk -F '","' '{print $8}')
        set cur_directory $(echo $cur_line | awk -F '","' '{print $9}')
        set cur_modifiers_items $(echo $cur_line | awk -F '","' '{print $10}'|string split '|')
    else # normal trees
        set cur_line $(sed -n $(random 2 $trees_len)p $trees_csv|sed 's/"$//'|sed 's/^"//')
    end

    set cur_type $(echo $cur_line | awk -F '","' '{print $1}')
    set cur_stage $(echo $cur_line | awk -F '","' '{print $2}')
    set cur_sensory $(echo $cur_line | awk -F '","' '{print $3}')
    set cur_minbranch $(echo $cur_line | awk -F '","' '{print $4}')
    set cur_maxbranch $(echo $cur_line | awk -F '","' '{print $5}')
    set cur_items $(echo $cur_line | awk -F '","' '{print $6}'|string split '|')
    set cur_items_len $(
    for i in $cur_items
        echo 1
    end|wc -l
    )
    set cur_branch_items $(echo $cur_line | awk -F '","' '{print $7}'|string split '|')
    set cur_branch_items_len $(
    for i in $cur_branch_items
        echo 1
    end|wc -l
    )
    #set cur_modifiers_items $(echo $cur_line | awk -F '","' '{print $7}'|string split '|')
    set cur_modifiers_items_len $(
    for i in $cur_modifiers_items
        echo 1
    end|wc -l
    )

    # for stupid computers
    if test $cur_minbranch -lt $cur_maxbranch
        set cur_branches $(random $cur_minbranch $cur_maxbranch)
    else
        set cur_branches $cur_minbranch
    end

    # set base items len
    set random_val $(random 1 10)
    if contains -- $random_val 1 # 3 items
        set cur_items_count 3
    else if contains -- $random_val 2 3 # 2 items
        set cur_items_count 2
    else if contains -- $random_val 4 5 6 # 1 item
        set cur_items_count 1
    else if contains -- $random_val 7 8 9 10
        set cur_items_count 0
    end

    # make tree, add descriptions
    mkdir ./portal/forest/tree_$current_tree_num
    echo $cur_stage $cur_type >> ./portal/forest/tree_$current_tree_num/description.txt
    echo >> ./portal/forest/tree_$current_tree_num/description.txt
    echo $cur_sensory >> ./portal/forest/tree_$current_tree_num/description.txt
    echo >> ./portal/forest/tree_$current_tree_num/description.txt
    echo $cur_modifiers >> ./portal/forest/tree_$current_tree_num/description.txt

    # add items to tree base
    #echo THE LINE NOW
    #echo $cur_line
    for e in $(seq $cur_items_count)
        #set $cur_items_len
        #if contains -- $cur_line fire lightning
        #    echo SHOULD FAIL SOON
        #end
        set cur_item_id $(echo $cur_items[$(random 1 $cur_items_len|grep -v '^0$')])
        set cur_item (cat $tree_items|grep '^"'$cur_item_id'"'|sed 's/^"//'|sed 's/"$//'|string split '","')
        echo $cur_item[3] > ./portal/forest/tree_$current_tree_num/$e\_$cur_item[2].txt
    end

    # add branches
    for e in $(seq $cur_branches)
        mkdir ./portal/forest/tree_$current_tree_num/branch_$e

        # set branch items count
        set random_val $(random 1 10)
        if contains -- $random_val 1 10 # 3 items (I went and made this 2 since we only match 5)
            set cur_branch_items_count 2
        else if contains -- $random_val 2 3 9 # 2 items
            set cur_branch_items_count 2
        else if contains -- $random_val 4 5 6 8 # 1 item
            set cur_branch_items_count 1
        else if contains -- $random_val 7
            set cur_branch_items_count 0
        end

        for a in $(seq $cur_branch_items_count)
            set cur_branch_item_id $(echo $cur_branch_items[$(random 1 $cur_branch_items_len|grep -v '^0$')])
            set cur_branch_item (cat $branch_items|grep '^"'$cur_branch_item_id'"'|sed 's/^"//'|sed 's/"$//'|string split '","')
            echo $cur_branch_item[3] > ./portal/forest/tree_$current_tree_num/branch_$e/$a\_$cur_branch_item[2].txt || begin
                echo $cur_branch_item_id
                echo $cur_branch_item
                echo $cur_branch_item[3]
                echo $tree_$current_tree_num
                echo branch_$e
            end
        end
    end


    # set modifier items len
    set random_val $(random 1 10)
    if contains -- $random_val 1 2 3 # 3 items
        set cur_modifiers_items_count 3
    else if contains -- $random_val 4 5 6 # 2 items
        set cur_modifiers_items_count 2
    else if contains -- $random_val 8 9 10 # 1 item
        set cur_modifiers_items_count 1
    else if contains -- $random_val 7
        set cur_modifiers_items_count 0
    end

    if test "$cur_directory"
        # create modifier directory and add items
        mkdir ./portal/forest/tree_$current_tree_num/$cur_directory

        for e in $(seq $cur_modifiers_items_count)
            set cur_modifier_item_id $(echo $cur_modifiers_items[$(random 1 $cur_modifiers_items_len|grep -v '^0$')])
            set cur_modifier_item (cat $modifier_items|grep '^"'$cur_modifier_item_id'"'|sed 's/^"//'|sed 's/"$//'|string split '","')
            echo $cur_modifier_item[3] > ./portal/forest/tree_$current_tree_num/$cur_directory/$cur_modifier_item[2].txt
            #echo $cur_modifier_item[3] > ./forest/tree_$current_tree_num/modifier_$e/$cur_modifier_item[2].txt
        end
    end



    #echo cur_line $cur_line
    #echo cur_type $cur_type
    #echo cur_stage $cur_stage
    #echo cur_sensory $cur_sensory
    #echo cur_minbranch $cur_minbranch
    #echo cur_maxbranch $cur_maxbranch
    #echo cur_items $cur_items
    #echo cur_branch_items $cur_branch_items
    #echo cur_modifiers $cur_modifiers
    #echo cur_directory $cur_directory
    #echo cur_modifiers_items $cur_modifiers_items
    #
    #echo cur_items_count $cur_items_count
    #echo cur_branch_items_count $cur_branch_items_count
    #echo cur_modifiers_items_len $cur_modifiers_items_len

    #set cur_items
    #set cur_branch_items
    #set cur_item
    #set cur_branch_item
    #set cur_modifier
    #set cur_modifier_item

    #
    #
## tar stuff {{{
#    tar -rvf ./portal.tar ./forest/tree_$i
#    tar -rvf ./portal.tar ./forest/$cur_ground_line[2]_$i
#    rm -rf ./forest/tree_$i
#    rm -rf ./forest/$cur_ground_line[2]_$i
## }}}
end
# }}}

#archivemount ./portal.tar ./portal

#mv ./forest ./portal/

# old way
#set mv_me $(ls ./portal/forest|shuf)
#for i in $(seq $(count $mv_me))
#    echo cleaning up $i
#    set basename $(echo $mv_me[$i]|sed 's/_[0-9][0-9]*//')
#    mv ./portal/forest/$mv_me[$i] ./portal/forest/$i"_"$basename
#end

# new way
for old_name in $(ls ./portal/forest)
    set new_name $(echo $old_name|sed 's/\(.*\)_\([0-9]*\)/\2_\1/')
    echo cleaning up $old_name to $new_name
    mv ./portal/forest/$old_name ./portal/forest/$new_name
end

# TODO {{{
# fire_sapling_poor_guy
# lightning_sapling_poor_guy
# lightning_aged
# lightning_recent
# etc.
# need to account for these (or change them)
# }}}

# Actual game content {{{

# more (FIRST LESSON HAS BEEN MOVED TO THE BOTTOM OF THIS SCRIPT) {{{
echo "Generating quest content now..."
# }}}

# cd,ls,cat,apology,pipetease {{{
echo "

====== Mister Orator, Reading Expert: ======

Hi again. Sorry, I should be more patient.

Well, you invoked me, your first incantation: » more «

If you want to do anything around here---even basic stuff like walking around or seeing your surroundings---you need to use an incantation. If you want to walk through the portal rather than being rude and talking to me through it like this, use the incantation: » cd «

So try it out now.

» cd portal «

To see what's around you, you can use the incantation: » ls «

You should see me in there. I'm the cat, of course. 

You can invoke me by just saying » cat « too. Like » cat portal/i_am_not_a_giant_noob «. I do find that rude, though (you don't see me calling you \"human,\" do you?), so I won't slow down for you. I read *really* fast too. If you want, you can invoke me that way instead. But use » more « if there's a whole lotta text that won't fit on your screen.

Well, I guess that's a lot to take in. So I'll break it down:

To move around:
» cd portal «

To look around:
» ls «

To talk to somebody (really, you're reading a thing):
» more something.txt «
Then press » [Q] « to quit immediately or » [Enter] « to scroll.

To also read something:
» cat i_am_not_a_giant_noob.txt «

And finally, if you decide to just go off and do whatever (please don't 🥴), you can always go back to where you came from by using:
» cd .. «

I'll explain more about what two dots represent later, but for now, just go through the portal, look for me, and talk to me. 🙄

Oh, and one more thing. If you mess up an incanation and get a weird message, don't be afraid of it. The forest is merely trying to give you hints/helpful advice; it's not yelling at you or anything. Unfortunately, it uses the language of the bWFjaGluZXM, but if you read carefully, I think you'll understand these hints.

Anyway, I'll see you in the portal. Good luck!

" >> ./portal/i_am_a_giant_noob.txt

echo "

====== note: ======

Did you use » cat « to read this message?

If you did, great. This will be more useful in the future when you learn how to bridge your incantations. The bWFjaGluZXM call this \"piping\"." >> ./portal/i_am_not_a_giant_noob.txt


echo "

====== note: ======

Sorry again. We all have to start somewhere, don't we? And you're starting now. That's the important part. Hell, that's the most important part. You *want* to learn! And isn't that beautiful?

You're beautiful.

And I love you.

Too much?

Too bad.

👄 MUAH!!! 👄

😽">> ./portal/apology.txt

# }}}

# ┌  ┐
# └  ┘
# « »

# slash, dots {{{
echo "

====== Mister Orator, Reading Expert: ======

You did it! Good job! I didn't doubt you for a second.

Anyway, did you see the forest over there? You can go ahead and walk into it. Hell, you can explore it too. There's a *lot* to explore.

Oh, I never told you what two dots mean.

In this language of incantations, two dots means \"backwards\". One dot means \"here\". When you incanted » ls « earlier, you really incated » ls . « But the magic here isn't stupid so it knew that all on its own. But this means you can look anywhere without actually having to go there, like » ls forest « for example.

So if you ever want to go back to where you came from---or, more specifically, outside of wherever you are---just use the incantation: » cd .. «

Places are separated by a slash: » / «

So, want to go back even farther?: » cd ../../ «

Want to see what's on a branch without going there?: » ls 1337_tree/branch_1 «

Remember earlier, when you incanted » more portal/i_am_a_giant_noob.txt «?

You used a slash there because you were standing right outside of the portal. I... hope you get the picture by now?

Well, what are you waiting for? Go into the forest. Look around. You can find me 1337_tree.

By the way, if you ever forget something, you can *probably* just hit the [Up Arrow] to see what incantations you already... incanted.

" >> ./portal/cat.txt

# }}}

# 1337_tree, noob_guide (unfinished), pwd, ls -a, find shy guy {{{
rm -rf ./portal/forest/1337_tree
mkdir -p ./portal/forest/1337_tree/branch_1
mkdir -p ./portal/forest/1337_tree/branch_2
echo "This is Mister Orator, Reading Expert's favorite tree. It's not really a tree, but a scratching post... the kind you get from a pet store. 

The scratches spell out the letters '1337'...

Is this guy for real?

Well, you can see him clearly, licking his paw up on branch_1.

Why don't you go up on the branch and talk to him again?

" >> ./portal/forest/1337_tree/description.txt

# Oh, right. Uhh. The scratching post smells of cat and when the wind hits it it's like whoosh and stuff and blows fur all over the place.

#echo "
#Incantation|description|examples
#___________|___________|_________
#pwd|invoke this if you ever get lost to see where you are|
#cd|invoke this to go places|cd ../
#||cd 1337_tree/
#||cd 1337_tree/branch_1
#cat|invoke this to 'read' something|cat 1337_tree/branch_1/cat.txt
#" | column -t -s '|' >> ./portal/forest/1337_tree/branch_2/noob_guide1.txt

echo "
====== First Noob Guide ======
(Sorry, this isn't great yet and is still being edited)
== pwd ==
Invoke this if you ever get lost to see where you are.

== cd ==
Invoke this to move around.
= Examples =
cd 1337_tree/branch_1 # from outside of the tree, go directly into the first branch
cd .. # go \"outside\" of wherever you are

== ls ==
Invoke this to look around
= Examples =
ls # invoke this to see what's around you now. Same as ls . and ls ./
ls 1337_tree # invoke this to see what's in 1337_tree
ls -a # adding -a exposes hidden things.

== more ==
Invoke this to read something. [Enter] to scroll. [Q] to quit.
= Examples =
more some_text.txt

== cat ==
Invoke this to read something. [Enter] to scroll. [Q] to quit.
= Examples =
cat ../branch_2/something.txt

"  >> ./portal/forest/1337_tree/branch_2/noob_guide1.txt

echo "

====== Mister Orator, Reading Expert: ======

Hey! You found me!

Pretty big forest, huh? Did you cast » ls « when you were standing in it? You should if you haven't already. It's MASSIVE!

Here's another incantation in case you ever get lost: » pwd «

This will tell you wherever you are, so you can better find your way around.

Anyway, I don't wanna remind you all the time of the things you've learned so far. So I'll start writing them down. You can find the first guidebook in the other branch.

Don't feel the need? Fine, skip it. I'm not the police. But somebody here---yes, here, on this branch---wants to meet you. What, you couldn't see them? They're pretty shy, so they like to remain hidden.

I guess it's time to teach you something new. You can use different *inflections* with your incantations too! (bWFjaGluZXM call these \"options\" or \"flags\")

Time to teach you your first inflection... it is...

...

...

» ls -a «

!!!!!!!!!!

What, did you expect something more complicated? Shut up. Try it out here on branch_1. And don't forget about my guidebook over there.

" >> ./portal/forest/1337_tree/branch_1/cat.txt

# }}}

# scroll: syntax1, meeting shy guy, pipes, grep, find shy guy rock {{{

echo "

====== first scroll of syntax: ======

» incantation «» inflection  «»  offering «
» ls          «» -a          «»  ./tree   «

Such is the structure of an incantation. Everything in this world starts with an incantation. The above will reveal to the spellcaster what is in the tree, including what may be hidden.

» . « denotes \"here\"

» .. « denotes \"before here\"

and » / « denotes the separation of places.

Incantations are case-sensitive. So be mindful of this when casting them.

Many incantations can be bridged to one another. This world is built on this principle. The forest you are in was built with this principle.

" >> ./portal/forest/1337_tree/branch_1/.scroll_fragment_01.txt

echo "

====== shy guy: ======

Oh! Uh... hi...

Did Mister Orator tell you that I wanted to talk? Why's he always do that...? I mean, sorry, I did, I just... he's so pushy...

Really, it's not hard to hide things in this forest---anything that starts with a period is hidden. So I hid myself, for OBVIOUS REASONS, but noooo.

Whatever. I can teach you how to bridge two incantations together---so that the output of one incantation can become the input of another one. To do this, you just use the \"pipe\" character (this is [Shift] + \ if you don't know... and if you don't know where \ is, it's that key that should be below [Backspace] and above [Enter]... and if it's not there because you bought some fancy keyboard... don't give those people any more of your hard-earned money ever again. They don't deserve it.) 

So you use it like:

» incantation1 | incantation2 «

However, I saw the guide up on branch_02 that Mister Orator gave you, and you don't seem to have anything really that useful to bridge together...

That's fine. I know the *perfect* one to teach you for bridging incantations. The forest can be overwhelming, so this incantation invokes the \"deep listening\" technique: » grep «.

You remember how to look around, right? With » ls «? Or, I guess to find me, you needed » ls -a «.

Well, I left a note in the forest, under a rock. You can go back into it now or refresh yourself with Mister Orator's guide up in branch_2. I'll still be here whenever you're ready to look for my note in the forest. When you're back in the forest, just invoke:

» ls | grep suspicious «

And you should find it in no time.

" >> ./portal/forest/1337_tree/branch_1/.shy_guy.txt

# }}}

# put the deep listening scroll here too? Yes vvv

# shy guy rock, SCROLL:grep, hidden items, explore some, meet orator at 69 tree {{{
rm -rf ./portal/forest/14_tree
mkdir -p ./portal/forest/14_suspicious_boulder

# EDIT HERE
# Also, whenever we make cat talk to player again, have cat mention that you can pipe to more as well.

echo "

====== second scroll of syntax: ======

» incantation «» inflection  «»  offering «» bridge «» incantation «» inflection «» offering
» ls          «» -a          «»  ./tree   «»    |   «»  grep       «» -i         «» hello

Such is an extended structure of an incantation. Everything in this world starts with an incantation. The above will reveal to the spellcaster what is in the tree, but only that which contains \"hello\", regardless of upper/lowercase (the inflection » -i «, for \"ignore\", in the incantation » grep « achieves this). One may use as many bridges between incantations as they desire.

Indeed, offerings are separated by spaces, but what if your offering *has* spaces?

» incantation «» inflection  «»  offering              «
» ls          «» -a          «»  ./\"portal to there\" «
» ls          «» -l          «»  ./'portal to there'   «

One may simply surround them with » \" « or » ' «

But what if your offering has spaces and » \" « or » ' «?

» incantation «» inflection  «»  offering                         «
» ls          «» -l          «» ./portal to \\\"l'endroit\\\"\" «

Then a » \\ « may be used to escape such characters. This even works on spaces, like so:

» incantation «» inflection  «»  offering                         «
» ls          «» -l          «» ./portal\\ to\\ there «

Incantations are case-sensitive. So be mindful of this when casting them.

Many incantations can be bridged to one another. This world is built on this principle. The forest you are in was built with this principle.

" >> ./portal/forest/14_suspicious_boulder/.scroll_fragment_02.txt

echo "

====== first scroll of deep listening: ======

The incantation, » grep «, used with a bridge, can be used as a filter for what was input into it.

» echo hello\nmy\nfriend | grep friend «

However, this incantation has several other uses. This incantation actually uses regular expressions (regex), and though this is not a regex scroll, we will go over the basics...

» echo hello\nmy\nfriend | grep 'friend|hello' «
» echo hello\nmy\nfriend | grep \"friend|hello\" «

The pipe here denotes an OR, thus both 'hello' and 'friend' will be returned. 

Note the use of single or double quotes here, for as you already know, the | represents a bridge in this language. To prevent that, quotes must be used.

» echo hello\nmy\nfriend | grep fr.end «

The period here denotes any character, thus it will still return 'friend'.

» echo hello\nmy\nfriend | grep 'f.*' «
» echo hello\nmy\nfriend | grep \"f.*\" «

The * here denotes any number of times the previous character ('any character' in this case since it was a period) appears. Thus, once again, this will still return 'friend'.

Note the use of single or double quotes here as well, for, like the bridge character, * represents something else entirely in this language unless it is surrounded by such quotes.

Many incantations can be bridged to one another. This world is built on this principle. The forest you are in was built with this principle.

" >> ./portal/forest/14_suspicious_boulder/.scroll_fragment_03.txt

#echo "
#
#====== scroll of speech: ======
#
#The incantation, » echo «, may be used to speak. Used with a bridge
#
#echo hello\nmy\nfriend | grep friend
#
#" >> ./portal/forest/14_suspicious_boulder/.scroll_fragment_01.txt

echo "

====== note: ======

I'm glad you found my note. That's some really good work. Maybe you could help me out with something later... 

You know what, though? I just remembered that you did already have a useful incantation for bridging---and it's Mister Orator himself. Duh. You've tried to look at the entire forest by now, right? Overwhelming indeed. Thank goodness for the deep listening incantation. Well, you can bridge to » more « as well, so that you can look at everything much more easily! For example...

» ls forest | more «

or, I guess from where you're (probably) standing...:

» ls ../ | more «

In any case, Mister Orator, Reading Expert wanted to talk to you again. He told me he'd be at 69_tree.

That's a pretty easy number to remember, though, don't you think? And you've done a lot of adventuring today; why not relax a bit and just see what the forest has to offer?

So if you want to take a load off, maybe start with taking a closer look where you found this note. You're bound to find something you'll like.

Don't forget, though. 69_tree. Maybe write it down somewhere?

" >> ./portal/forest/14_suspicious_boulder/note.txt

# }}}

# 69 tree quest; the main script has been modified so that this is always a lightning_aged oak {{{
echo "

====== not cat ======

It's nice to see a fellow human. I see you've grown adept at moving around here. That's good.

But can you *see* around here? Can you see... everything, all at once?

No, of course not. Not yet, at least.

You were looking for the cat, no? He's somewhere in this tree. It'd be a pain to look through all of the branches without a new incantation. This tree is massive.

There's a scroll here in the scar of this tree. It'll teach you what you need, but you'll need to remember how to use bridges and the Deep Listening incantation to find it, as somebody left an absurd amount of paper in there. I suspect it tells a story if you can decipher it. After you find the scroll, you'll need bridges and the Deep Listening incantation again to find the cat.

But perchance you were lost in the forest and lost a little bit of your memory along the way? Very well, I can remind you how to use deep listening...

» ls some_place | grep -i what_i_wish_to_find «

If you were asleep during that class, the inflection » -i « makes it so that what you are looking for ignores case.

Well, off you go then.

(Just kidding. The main questline ends here as I'm not done editing. Sorry lol. As a placeholder, I put the 'tldr' page for 'find' in there somewhere instead. Mister Orator is here too, but his dialogue is unfinished as well.)

" >> ./portal/forest/69_tree/not_cat.txt
# Script to generate smaller branches, to make it hard to find cat..
for eb in $(ls ./portal/forest/69_tree/ | grep branch)
    for i in $(seq 1 $(random 2 3))
        mkdir ./portal/forest/69_tree/$eb/smaller_branch_$i
        for ii in $(seq 1 $(random 3 6))
            mkdir ./portal/forest/69_tree/$eb/smaller_branch_$i/smaller_branch_$ii
            for iii in $(seq 1 $(random 4 6))
                mkdir ./portal/forest/69_tree/$eb/smaller_branch_$i/smaller_branch_$ii/smaller_branch$iii
            end
        end
    end
end

# Script to generate the engravings in the lightning scar.
mkdir -p ./portal/forest/69_tree/lightning_scar
set thestory
set thestoryb64url
set thestory $(sed -n 2p ./quests/files/tree_engraving_story.txt|sed 's/ /\n/g')
for e in $thestory
    set -a thestoryb64url $(echo $e|basenc --base64url)
end

for i in $(seq $(count $thestoryb64url))
    set -a theword $thestoryb64url[$i]
    if not contains "$theword" $(ls)
        touch ./portal/forest/69_tree/lightning_scar/"$theword"
        set theword
    end
end

echo "
====== first scroll of the God's Eye incantation: ======

  - Find files by extension:
    find path/to/directory -name '*.ext'

  - Find files matching multiple path/name patterns:
    find path/to/directory -path '*/path/*/*.ext' -or -name '*pattern*'

  - Find directories matching a given name, in case-insensitive mode:
    find path/to/directory -type d -iname '*lib*'

  - Find files matching a given pattern, excluding specific paths:
    find path/to/directory -name '*.py' -not -path '*/site-packages/*'

  - Find files matching a given size range, limiting the recursive depth to "1":
    find path/to/directory -maxdepth 1 -size +500k -size -10M

  - Run a command for each file (use {} within the command to access the filename):
    find path/to/directory -name '*.ext' -exec wc -l {} \;

  - Find all files modified today and pass the results to a single command as arguments:
    find path/to/directory -daystart -mtime -1 -exec tar -cvf archive.tar {} \+

  - Search for either empty files or directories and delete them verbosely:
    find path/to/directory -type f|d -empty -delete -print
" >> ./portal/forest/69_tree/lightning_scar/a_scroll_fragment.txt # starting it with "a" because that's common but starting with "s" isn't so common.

# script to put cat somewhere random
set putcatherelol $(find ./portal/forest/69_tree/ -mindepth 4 | head -n -15 | tail -n +16 | shuf | head -n1)

echo "

====== Mister Orator, Reading Expert: ======

touch... mkdir... tee... rm... find... cp... mv...

~ Mister Orator continues mumbling to himself, staring up at the sky ~

A long time ago, I climbed this tree to feel closer to the sky. That day, sky came to me...

~ his gaze darts downward, locking with yours ~

So you found the God's Eye scroll, and used the its incantation to find me. There are other such abilities too. Creation. Destruction...

These are not to be taken lightly.

~ he actually seems serious for once, hesitant even ~

Nevertheless, you should know them. Everybody should. This forest is not something to be afraid of. You've been made to fear it, to fear your very own abilities, by those that would turn the whole world into zombies if it enriched them...

No...

No more.

First, you must create a new branch. Yes, here. I know you can do it. You can create any place with the incantation » mkdir «, any place that you wish to step into. For now, you must make a playground from which you will practice these new incantations.

I left another n00b guide here. You will need to copy it into your playground---yes, a creation incanation. That incanation is » cp «.

To be more straightforward, do this:

» mkdir playground «

Then look. Just use » ls «. You can see your own creation. Then...:

» cp .noob_guide2.txt ./playground/noob_guide2.txt «

Did you notice? You can choose the name of the copy. In this case, we're removing the period so that it is no longer hidden.

Anyway, after that, go into the playground and read the n00b guide.

Good luck and... frankly? Have fun.

" >> $putcatherelol/cat.txt

echo "
====== Noob Guide of Creation and Destruction ======

If you are not in a sandbox or a playground, do enter one before you practice the following. You may skip the following if you're already in one. But if not, speak to Mister Orator here:
$(realpath $putcatherelol/cat.txt)

So let's begin. I leave the exploration to you here. There are no tasks, no goals, no people to speak to. You may read this, try a few incanations, use the » ls « and » more « incanations to see what you've done, and then read it again, and then try a few more incanations, etc. etc. Remember, you can press [Q] to quit reading this early if there's something you want to try immediately.

You are safe to do as you wish in this playground provided none of your offerings contain \"..\" or begin with \"/\". Did you miss the lesson on what an offering is? Quick refresher then:

» incantation «» inflection  «»  offering «
» ls          «» -a          «»  ./tree   «

Now, you've already learned two creation incanations. Allow me to teach you a few inflections for what you've already learned:

» mkdir -p a_place/another_place/another_place «

This inflection, » -p «, will allow you to create places within places at once.

» cp -r a_place yet_another_place «

When you copy a *thing,* you will not need this. But when you copy a *place,* this inflection says to copy all places and things *within* that place as well. Typically, you will need this when copying most places, for most places are filled with things, are they not?

You have learned to make places. Now to make *things.*

» touch a_thing.txt «
» touch ./a_thing.txt «

The above two are functionally equivalent. If you recall, a period represents 'here.' Of course, like all incanatations, you can use slashes to specify places too.

» touch « creates a thing where there was nothing. But it creates only an empty vessel. It is the quietest of the creation incantations. It simply *is,* where before it was not.

But an empty vessel is a lonely thing. So fill it:

» echo 'some words' > a_thing.txt «
» echo 'some words' | tee a_thing.txt «

» > « is not an incantation per se. It is not unlike a bridge, but it is a bridge to a *thing.* Similarly, » tee « redirects to a thing too, except via a bridge. The difference between these two is that with » tee «, you will still witness what you are filling that vessel with, and thus you can still be bridge that to yet another incanation---» > «, on the other hand, does not contain this output. But be warned: these are not gentle. They do not add. They *entirely replace* whatever was in the vessel.

If you wish to add without destroying, you may use these:

» echo 'more words' >> a_thing.txt «
» echo 'more words' tee -a a_thing.txt «

One more arrow---the gesture of *continuing* a thought rather than replacing it. Or one tiny inflection » -a «---to *add* rather than replace.

This incanation, » tee «, and these gestures, » > «/» >> «, can create too---you do not need to use » touch « first.

>> is a scribe that reads aloud as they write

Now, moving and renaming...

» mv a_thing.txt a_new_name.txt «
» mv a_new_name.txt some_EXISTING_place «
» mv some_EXISTING_place/a_new_name.txt ./a_thing.txt «

Assuming some_EXISTING_place does, in fact, already exist, if the three incanations are cast in the order as the above, you will go back to where you began. The first one renames a_thing.txt to a_new_name.txt. The second one moves a_new_name.txt to some_EXISTING_place. The third one moves a_new_name.txt from some_EXISTING_place back to wherever you currently are. 

Confused? Just remember that to move a thing to a new place is to just give it a new name. 

Still confused? That's fine. Just try it out!

Oh, and be careful. If you move a thing onto a name that is already taken, the thing that was there is *replaced.* Quietly and without ceremony. So aim true!

» mv a_place another_place/ «

...moves an entire place, and everything in it. No inflection needed this time---» mv « understands places already.

And finally. Destruction...

» rm a_thing.txt «

» rm « is the incantation of *removal.* It does what it says. It does not ask. It does not warn. It does not set the thing aside in some softer place from which it might later be recovered. It is *gone.*

» rm -r a_place «

The » -r « inflection means \"and everything within.\" This will remove a place, and every thing and every place inside it, and everything inside *those,* in one breath. There are no recycle bins here, and the forest will not ask if you're sure.

Seriously, be careful with this. I have seen people lose years of work to a single mistake in an » rm « incanation. You can get these things back, but not always, and it's not covered in these lessons. I say this knowing you will *eventually* make a mistake---every forest dweller has been there, even the creator of *this* forest has, but I did teach you how to » cp -r «, did I not?

But don't be afraid of any of these incanations. Just respect them. Even » rm « is not wicked, it is merely how you clean up after yourself, how you undo a thing you made by mistake, how you make room for what comes next. Creation without destruction is hoarding. Destruction without creation is vandalism. You must learn both, and you must learn to choose between them.

Go now. Practice. Make mistakes. The forest is forgiving, if you are careful.

Oh, and one more thing? I left a scroll 

" >> $putcatherelol/.noob_guide2.txt

#For now, I will teach you creation, and only creation. (touch, cp and tee for now)
#
#The forest is yours, after all. (perhaps say this later? with destruction?)
#
#Sorry, quest ends here. It's still a work in progress.


# cat says:
# touch... mkdir... tee... rm... find... cp... mv...
# Mister orator continues mumbling to himself, staring up at the sky.
# a long time ago, I climbed this tree to feel closer to the sky. That day, sky came to me...
# he sounds pensive/thoughtful/idk while staring up at the sky. Then he puts his attention back to you.
# So you found the God's Eye scroll, and used the God's Eye to find me?
# There are more godly abilities too. Creation. Destruction...
# These are not to be taken lightly. 
# He actually seems serious for once, hesitant even.
# Nevertheless, you should know them. Everyone should. This forest is not something to be afraid of. You've been made to fear it, to fear your very own abilities, by those that would turn the whole world into zombies if it enriched them...
# No... No more.
# First, you must create a new branch. Yes, here. I know you can do it. You can create any place with this incantation, any place that you wish to step into. Right now, you will make a sandbox from which you will practice these new incantations. 
# Then the user must copy a guide into the branch.
# For now, I will teach you creation, and only creation.
# The forest is yours, after all. (perhaps later?)

# The scroll itself? It ends with "Mister Orator is in this very tree somewhere, among one of the many old branches. Find him. And when you do, walk (cd) to him. Then speak to him. There is so much more to learn.

# }}}

# Don't feel the need? Fine, skip it. I'm not the police. But I found a note from somebody who wanted to talk to you. They said they're waiting in the forest for you. Good luck finding them without that note.

# }}}


# /etc/os-release


echo Adding ascii art.

# Add ascii art (scripted) {{{
for i in $(find ./portal -type f | grep '/[\.0-9a-z_]*.txt$')
    set filetext
    set asciiart
    set filetext "$(cat $i)"
    if echo $i | grep tree/description.txt > /dev/null
        set treetype $(echo $filetext | head -n1 | awk '{print $1}')
        if test -f ./ascii_art_useme/tree_types/tree-$treetype
            echo adding ascii art to $i
            #echo ./ascii_art_useme/tree_types/tree-$treetype
            set asciiart "$(cat ./ascii_art_useme/tree_types/tree-$treetype)"
            echo $asciiart > $i
            echo >> $i
            echo $filetext >> $i
            echo $i
        end
    else
        set matchname $(basename $i | sed 's/[0-9]*_//' | sed 's/\.txt//')
        if test -f ./ascii_art_useme/$matchname
            echo adding ascii art to $i
            set asciiart "$(cat ./ascii_art_useme/$matchname)" > /dev/null
            echo $asciiart > $i
            echo >> $i
            echo $filetext >> $i
            echo $i
        end
    end
end



# }}}

# Add ascii art (manual) {{{
# mister orator to cat.txt
for i in $(find ./portal -type f | grep '/cat\.txt')
    set filetext
    set asciiart
    set filetext "$(cat $i)"
    set asciiart "$(cat ./ascii_art_useme/mister-orator)"
    echo $asciiart > $i
    echo >> $i
    echo $filetext >> $i
end
# }}}

# just straight manual ones {{{
# mister orator
set manual_add_asciis
set -a manual_add_asciis ./portal/i_am_a_giant_noob.txt
for i in $manual_add_asciis
    set filetext
    set asciiart
    set filetext "$(cat $i)"
    set asciiart "$(cat ./ascii_art_useme/mister-orator)"
    echo $asciiart > $i
    echo >> $i
    echo $filetext >> $i
end

# notes
set manual_add_asciis
set -a manual_add_asciis ./portal/apology.txt ./portal/i_am_not_a_giant_noob.txt
set -a manual_add_asciis $(find ./portal -type f -iname '*noob_guide*')
for i in $manual_add_asciis
    set filetext
    set asciiart
    set filetext "$(cat $i)"
    set asciiart "$(cat ./ascii_art_useme/note)"
    echo $asciiart > $i
    echo >> $i
    echo $filetext >> $i
end

# scrolls
set manual_add_asciis
for i in $(find ./portal/ -type f | grep 'scroll[_a-z0-9]*\.txt')
    set filetext
    set asciiart
    set filetext "$(cat $i)"
    set asciiart "$(cat ./ascii_art_useme/scroll)"
    echo $asciiart > $i
    echo >> $i
    echo $filetext >> $i
end

# not-cat to not_cat
for i in $(find ./portal -type f | grep not_cat\.txt)
    set filetext
    set asciiart
    set filetext "$(cat $i)"
    set asciiart "$(cat ./ascii_art_useme/not-cat)"
    echo $asciiart > $i
    echo >> $i
    echo $filetext >> $i
end

# shy-guy
for i in $(find ./portal -type f | grep shy.guy\.txt)
    set filetext
    set asciiart
    set filetext "$(cat $i)"
    set asciiart "$(cat ./ascii_art_useme/shy-guy)"
    echo $asciiart > $i
    echo >> $i
    echo $filetext >> $i
end

# 1337 tree
set filetext
set asciiart
set filenow ./portal/forest/1337_tree/description.txt
set filetext "$(cat $filenow)"
set asciiart "$(cat ./ascii_art_useme/1337_tree)"
echo $asciiart > $filenow
echo >> $filenow
echo $filetext >> $filenow

# 69 tree (temporary, need to get ascii for these)
set filetext
set asciiart
set filenow ./portal/forest/69_tree/description.txt
set filetext "$(cat $filenow)"
set asciiart "$(cat ./ascii_art_useme/tree_types/tree-aged)"
echo $asciiart > $filenow
echo >> $filenow
echo $filetext >> $filenow

# }}}

# more (FIRST LESSON HAS BEEN MOVED TO THE BOTTOM OF THIS SCRIPT) {{{
echo "

«« Press [Enter] to scroll »»

«« Press [Q] to quit (without reading the rest of this text) »»

Type » more starthere.txt « and then [Enter] to see this message again.

    *+:                                                  :*=.
   =####=:                                            -*###*-.
   *######=-                                        -+######*.
  =#########*:                                     *#########+.
  +###########+:                                :############*.
  +#############=                             :=#############=.
  +##############*-        ========:         +###############.
  +################# -=+##############*+:  =#################.
  =##########################################################.
  -*########################################################+.
   :########################################################.
   :#######################################################*.
    #######################################################:.
    +#####################################################+.
     *#####*+++++++++++*##############*+++++++++++++######.
    :*###+...:--------:..-*#########+...:--------...-*####.
    l:::::.:*#########*+:.::::::::::..-+#########*=..-::::::.
   -##*+=-.:############-.:########+..+###########*..-=*###-.
  -######+.:#####.#####+..:########+..+#####.#####*..+######+.
 ########*.:*##########=..:########+..=###########+..+#######*.
 =#######*:...=*******:..-##########*...+*******+...=#######+.
 :#########*=..........-*###+++===####*+.........-=#########*.
  :*########################*-...-#########################+=.
    ##########################+:*##########################.
     =###################=###*=-+###=###################*-.
       ###################+===##+===###################+:.
         :+##########################################+:.
           :=#####################################*:.
           :=######################################=:.
          +##########################################.

====== cat: ======

Welcome! I'm Mister Orator, Reading Expert!

I made a portal to the other world. It's conveniently called portal. You should try stepping through it.

What? You don't know what the other world is?

Wait, are you a n00b?

*sigh* That's fine. I guess.

You've got a lot to learn then.

First and foremost, everything in this world starts with an incantation. What are incantations? Well, the bWFjaGluZXM call them commands. Does that ring a bell? Are you a bWFjaGluZQo by any chance? No, no. You're a n00b. There's no way.

Well, I'll teach you your first one...

...

It's me, » more « (Mister Orator, Reading Expert)! 🥳

Try this out right now:

» more portal/i_am_a_giant_noob.txt «

You're actually using \"more\" right now. I mean like right *now* now. So those same buttons, [Enter] and [Q], will work the same way.

Remember, *everything* in this world starts with an incantation. Everything. No matter what you do, you say an incantation first. Got it?

If you're not a n00b, you can still have fun in the other world. Highly recommended. IGN says this was 8/10, but they would have given it a 10/10 because they said it was too hard. Typical.

(IGN didn't actually say anything about this. Please don't come after me. I'm just trying to help noobs)

Type » more starthere.txt « and then [Enter] to see this message again.

" | tee ./starthere.txt | more

# }}}
