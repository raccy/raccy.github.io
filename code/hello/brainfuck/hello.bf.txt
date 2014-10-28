++++++++ ++++++++       add 0x10 to #0
[                       while #0 eq 0 {
  > ++++++++ ++++++       add 0xE to #1
  > ++++++++              add 0x8 to #2
  > ++++++++ +            add 0x9 to #3
  > ++++++++ +++          add 0xB to #4
  > ++++++++ ++           add 0xA to #5
  > +                     add 0x1 to #6
  <<<<<< -                decr #0
]                       }
#mem 00 E0 80 90 B0 A0 10 p=0
print こ u3053 utf8 E3 81 93
> +++ .
> + .
> +++ .
#mem 00 E3 81 93 B0 A0 10 p=3
print ん u3093 utf8 E3 82 93
<< .
> + .
> .
#mem 00 E3 82 93 B0 A0 10 p=3
print に u306B utf8 E3 81 AB
<< .
> - .
>> ----- .
#mem 00 E3 81 93 AB A0 10 p=4
print ち u3061 utf8 E3 81 A1
<<< .
> .
>>> + .
#mem 00 E3 81 93 AB A1 10 p=5
print は u306F utf8 E3 81 AF
<<<< .
> .
>> ++++ .
#mem 00 E3 81 93 AF A1 10 p=4
print 、u8141 utf8 E3 80 81
<<< .
> - .
+ .
#mem 00 E3 81 93 AF A1 10 p=2
print 世 u4E16 utf8 E4 B8 96
< + .
>>> ++++++++ + .
< +++ .
#mem 00 E4 81 96 B8 A1 10 p=3
print 界 u754C utf8 E7 95 8C
<< +++ .
>> - .
-------- - .
#mem 00 E7 81 8C B8 A1 10 p=3
print ！ uFF01 utf8 EF BC 81
<< ++++++++ .
>>> ++++ .
<< .
#mem 00 EF 81 8C BC A1 10 p=2
print \n u000A utf8 0A
>>>> ------ .
#mem 00 EF 81 8C BC 8C 0A
