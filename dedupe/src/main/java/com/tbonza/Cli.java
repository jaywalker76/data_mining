package com.tbonza.dedupe;

import java.util.logging.Level;
import java.util.logging.Logger;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;


public class Cli {

	private static final Logger log =
	    Logger.getLogger(Cli.class.getName());
	private String[] args = null;
	private Options options = new Options();
	
	public Cli(String[] args)
	{
		this.args = args;
		
		options.addOption("h", "help", false, "show help.");
		options.addOption("i", "intext", true,
				  "Full filepath to text file (UTF-8).");
		options.addOption("o", "outcsv", true,
				  "Full filepath for csv output.");
	}	
	
	public void parse()
	{

		CommandLineParser parser = new DefaultParser();
		
		CommandLine cmd = null;
		try 
		{
			cmd = parser.parse(options, args);
			
			if (cmd.hasOption("h"))
			{
				help();
			}
			
			if (cmd.hasOption("i"))
			{
				log.log(Level.INFO,
					"Using cli argument -i=" +
					cmd.getOptionValue("i"));
				//parseDoc.Demo(cmd.getOptionValue("i"));
				//	String filecontents =
				//    ParseDoc.				\
				//    returnFile(cmd.getOptionValue("i"));
				//ParseDoc.printFirstToken(filecontents);
				
				
			} else {
				log.log(Level.SEVERE,
					"Missing i option");
				help();
			}
			
			if (cmd.hasOption("o"))
			{
			    //log.log(Level.INFO,
					//"Using cli argument -o=" + 
					//	cmd.getOptionValue("o"));
				//CSVFileWriter.			\
				      //WriteCsvFile(cmd.getOptionValue("o"),
				//cmd.getOptionValue("i"));
				//ParseDoc.Demo(cmd.getOptionValue("o"));
				
			} else {
				log.log(Level.SEVERE,
					"Missing o option");
				help();
			}
			
			
		} catch (ParseException e) {
			log.
			    log(Level.SEVERE,
				"Failed to parse cli properties", e);
			help();
		}
	}
	
	private void help()
	{
		HelpFormatter formatter = new HelpFormatter();
		
		formatter.printHelp("Main", options);
		System.exit(0);
	}
}
