/*
 * Copyright (C) 2015 Tyler Brown
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.tbonza.dedupe;

import org.apache.lucene.index.IndexWriter;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.util.ArrayList;


public class InputOutput {

    private IndexWriter writer;
    private ArrayList<File> queue = new ArrayList<File>();

    public static void main(String[] args) throws IOException {

	String indexLocation = null;
	String filepath = "";
	
	BufferedReader br = new BufferedReader(new InputStreamReader(filepath));
	String s = br.readLine();

	InputOutput indexer = null;
	try {
	    indexLocation = s;
	    indexer = new InputOutput(s);
	} catch (Exception ex) {
	    System.out.println("Cannot create index" +
			       ex.getMessage());
	    System.exit(-1);
	}

	// Read user input
	while (!s.equalsIgnoreCase("q")) {
	    try {
		System.out.println("Enter the full path to add into index");
		System.out.println("Use .txt");
		s = br.readLine();
		if (s.equalsIgnoreCase("q")) {
		    break;
		}

		// try to add file into the index
		indexer.indexFileOrDirectory(s);
	    } catch (Exception e) {
		System.out.println("Error indexing " + s + " : " +
				   e.getMessage());
	    }
	}

	// after adding, we always have to call the
	// closeIndex, otherwise the index is not created
	indexer.closeIndex();

	// ****
	// Skipping the search part
	// ****

    }

    /**
     * Constructor
     * @param indexDir the name of the folder where the index should be created.
     * @throws java.io.IOException when exception creating index.
     */
    TextFileIndexer(String indexDir) throws IOException {
	// the boolean true parameter means to create a new index everytime,
	// potentially overwriting any existing files there.
	FSDirectory dir = FSDirectory.open(new File(indexDir));

	IndexWriterConfig config = new IndexWriterConfig(Version.LUCENE_40,
							 analyzer);

	writer = new IndexWriter(dir, config);
    }

    /**
     * Indexes a file or directory
     * @param fileName the name of a text file or a folder we wish to index.
     * @throws java.io.IOException when exception
     */
    public void indexFileOrDirectory(String fileName) throws IOException {
	// ===========================================================
	// gets the list of files in a folder (if user has submitted
	// the name of a folder) or gets a single file name (if user
	// has submitted only the filename)
	// ============================================================
	addFiles(new File(fileName));

	int originalNumDocs = writer.numDocs();
	for (File f : queue) {
	    FileReader fr = null;
	    try {
		Document doc = new Document();

		// ================================
		// add contents of file
		// ================================
		fr = new FileReader(f);
		doc.add(new TextField("contents", fr));
		doc.add(new StringField("path", f.getPath(), Field.Store.YES));
		doc.add(new StringField("filename", f.getName(),
					Field.Store.YES));

		writer.addDocument(doc);
		System.out.println("Added: " + f);
	    } catch (Exception e) {
		System.out.println("Could not add: " + f);
	    } finally {
		fr.close();
	    }
	}

	int newNumDocs = writer.numDocs();
	System.out.println("");
	System.out.println("*********************");
	System.out.println((newNumDocs - originalNumDocs) + "documents added.");
	System.out.println("**********************");

	queue.clear();
    }

    private void addFiles(File file) {

	if (!file.exists()) {
	    System.out.println(file + " does not exist.");
	}
	if (file.isDirectory()) {
	    for (File f : file.listFiles()) {
		addFiles(f);
	    }
	} else {
	    String filename = file.getName().toLowerCase();
	    //===================================================
	    // Only index text files
	    //===================================================
	    if (filename.endsWith(".htm") || filename.endsWith(".html") || 
		filename.endsWith(".xml") || filename.endsWith(".txt")) {
		queue.add(file);
	    } else {
		System.out.println("Skipped " + filename);
	    }
	}
    }
    
    /**
     * Close the index.
     * @throws java.io.IOException when exception closing
     */
    public void closeIndex() throws IOException {
	writer.close();
    }

}
