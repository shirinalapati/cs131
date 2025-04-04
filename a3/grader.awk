#!/usr/bin/awk -f

# Function to calculate average
function getAverage(total, count) {
    return total / count
}

BEGIN {
    FS = ","  # Set comma as field separator
    highestTotal = -1
    lowestTotal = 100000
}

NR == 1 {
    next  # Skip header row
}

{


        name = $2 # Take student name from the 2nd column
        total = 0 # Initialize total score for this student
        for (i = 3; i<=NF; i++) { # Loop through columns 3 to NF, which is the number of fields
                total += $i # Get the total score
        }
        studentTotal[name] = total
        # Finding and storing average score
        avg = getAverage(total,NF - 2) # Subtract 2 to not include StudentID, name
        studentAvg[name] = avg

        if (avg>=70) {
                status[name] = "Pass"
        }
        else {
                status[name] = "Fail"
}
# Updating highest scoring student
        if (total > highestTotal) {
                highestTotal = total
                topStudent = name
        }
        # Updating lowest scoring student
        if (total < lowestTotal) {
                lowestTotal = total
                lowStudent = name
        }
}
END {
        print "Student Summary:\n"
        for (name in studentTotal) {
                printf "Name: %s\n", name
                printf "TotalScore: %d\n", studentTotal[name]
                printf "Average Score: %.2f\n", studentAvg[name]
                printf "Status: %s\n\n", status[name]
        }
        print "The top scoring student was : " topStudent " with " highestTotal " points"
        print "The lowest scoring student was : " lowStudent " with " lowestTotal " points"
}
