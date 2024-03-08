//
// This file holds several Groovy functions that could be useful for any Nextflow pipeline
//

import java.io.File
import org.codehaus.groovy.runtime.StackTraceUtils

class Utils {

    //
    // Retrieves the name file without extension
    //
    public static String getBaseName(String filePath) {
        def basename = new File(filePath).getBaseName()
        return basename
    }

    static def getCurrentMethodName(){
        def marker = new Throwable()
        return StackTraceUtils.sanitize(marker).stackTrace[1].methodName
    }

    //
    // Print file from the given string
    //
    public static String writeStrIntoFile(content, ifile) {
        // declare variable
        def ofile = ''
        try {
            ofile = new File(ifile)
            ofile.write(content)
        } catch(Exception ex) {
            println("ERROR: ${new Object(){}.getClass().getEnclosingMethod().getName()}: $ex.")
            System.exit(1)
        }
        return ofile
    }

    //
    // Extract the parameter section from a parameter file (INI)
    //
    public static String extractParamSection(ifile, section) {
        // declare variable
        def fileReader = ''
        try {
            // read the file contents into a variable
            def f = new File(ifile.toString())
            fileReader = f.text
        } catch(Exception ex) {
            println("ERROR: ${new Object(){}.getClass().getEnclosingMethod().getName()}: $ex.")
            System.exit(1)
        }
        return fileReader
    }

    //
    // Update the parameter file (INI) with the provided parameters
    //
    public static String updateParamsFile(ifile, replaces) {
        // declare variable
        def ofile = ''
        try {
            // read the file contents into a variable
            def f = new File(ifile.toString())
            def fileReader = f.text
            // replace attributes by the given ones
            replaces.each { replace ->
                def pattern = ~/${replace.key}\s*=.*/
                fileReader = fileReader.replaceAll(pattern,"${replace.key}=${replace.value}")
            }
            // define output file
            def ofilename = "${f.getParent()}${File.separator}updated_${f.name}"
            // write the output parameter file
            ofile = new File(ofilename)
            ofile.write(fileReader)

        } catch(Exception ex) {
            println("ERROR: ${new Object(){}.getClass().getEnclosingMethod().getName()}: $ex.")
            System.exit(1)
        }
        return ofile
    }


    // //
    // // Create report (list of maps) from an INI file
    // //
    // static def parseIniFile(fileName) {
    //     def result = []
    //     try {
    //         def fileReader = new File(fileName).text
    //         def currentSection = null
    //         fileReader.split("\n").each() { line ->
    //             line = line.trim()
    //             line = line.replaceAll(/(;|#).*/, '')
    //             if (line.startsWith("[")) {
    //                 // It's a section header
    //                 currentSection = line.replaceAll("\\[|\\]", "")
    //             } else if (line && !line.startsWith("#") && !line.startsWith(";")) {
    //                 // It's a key-value pair (not empty and not a comment)
    //                 def keyValue = line.split('=').collect { it.split('/(#|;)/')[0].trim() }
    //                 if (currentSection) {
    //                     // Add the key-value pair to the current section
    //                     result << ['section': currentSection, 'key': keyValue[0], 'value': keyValue[1]]
    //                 }
    //             }
    //         }
    //     } catch(Exception ex) {
    //         println("Catching the exception: ${ex}")
    //         System.exit(1)
    //     }
    //     return result
    // }

    // //
    // // Create report (map) with the parameters from the MSFragger file
    // //
    // static def parseMsfFile(fileName) {
    //     // declare variables
    //     def result = [:]
    //     try {
    //         def fileReader = new File(fileName).text
    //         def currentSection = null
    //         fileReader.split("\n").each() { line ->
    //             line = line.trim()
    //             if (line && !line.startsWith("#")) {
    //                 // It's a key-value pair (not empty and not a comment)
    //                 def keyValue = line.split('=').collect { it.split('#')[0].trim() }
    //                 def key = keyValue[0]
    //                 def val = keyValue[1]
    //                 if ( !result.containsKey(key) ) {
    //                     result[key] = val
    //                 }
    //                 else {
    //                     throw new Exception("Key '$key' is duplicated in the parameter file.")
    //                 }
    //             }
    //         }

    //     } catch(Exception ex) {
    //         println("ERROR:${new Object(){}.getClass().getEnclosingMethod().getName()}:$ex")
    //         System.exit(1)
    //     }

    //     return result
    // }

    // //
    // // Update the MSFragger parameter file with the provided parameters
    // //
    // public static Map updateMsfParams(String ifile, replaces) {
    //     // parse the MSF file
    //     def param_data = parseMsfFile(ifile.toString())
    //     // update the given attributes
    //     try {
    //         replaces.each { replace ->
    //             if ( param_data.containsKey(replace.key) ) {
    //                 param_data[replace.key] = replace.value
    //             }
    //             else {
    //                 throw new Exception("Key '$replace.key' is not in the parameter file.")
    //             }
    //         }
    //     } catch(Exception ex) {
    //         println("ERROR:${new Object(){}.getClass().getEnclosingMethod().getName()}:$ex")
    //         System.exit(1)
    //     }
    //     return param_data
    // }
}
