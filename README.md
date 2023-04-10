# DEPENDENCIES

If it is used from windows download Git BASH for having all BASH dependencies needed. From linux it is just needed BASH and AWK

# USE OF BSH FILE

Execute de conf.sh passing one argument wich is the path where the file will be located:

bash con.sh [LINUX/PATH/TO/THE/DIR]

# USE OF CHANGE FILE

This file is used for specifing the patters to be changed. They must be pairs of values in each line separated by a '@' character. All patters will be covered by double quotation marks.
The patters must follow the specifications of the AWK command so the special character such as '[' must be preceded by '\\' and so on but just in the first column of the file. Example:

original  ||  new

"_##car##\\)"@"_##car)"

"_##car##\\]"@"_##car]"

line 1: the patters to change is "_##car##)" to "_##car)"

# IMPORTANT LIMITATION

As the '@' is used for separating the patters this value cannot be used inside it
