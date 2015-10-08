package com.tbonza.dedupe;

import no.priv.garshol.duke.*;
import no.priv.garshol.duke.matchers.PrintMatchListener;

public class RunDuke {

    public static void main(String[] argv) throws Exception {
	Configuration config = ConfigLoader.load(argv[1]);
	Processor proc = new Processor(config);
	proc.addMatchListener(new PrintMatchListener(true, true, true,
						     false,
						     config.
						     getProperties(),
						     true));
	proc.deduplicate();
	proc.close()
    }
}
