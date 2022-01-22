/*
  RecBinarySearch.swift
  
  By Zefeng Wang
  Created on January 20, 2022
  
  This program uses a recursive function to find a specific element in a list in input.txt
  and outputs the index of that element to output.txt
*/

// import Foundation module
import Foundation

// Recursive function to take implement binary search of an array
func binarySearch(array: [Int], ele: Int, high: Int, low: Int) -> String {

	// Checks if array is sorted
	for val in 0..<array.count - 1 where array[val] > array[val + 1] {
		return "Please sort this list."
	}

	// Implements Binary Search
	let mid = low + (high - low) / 2

	if high >= low && array.count != 0 {
		if array[mid] == ele {
			return String(mid)
		} else if ele < array[mid] {
			return binarySearch(array: array, ele: ele, high: mid - 1, low: low)
		} else {
			return binarySearch(array: array, ele: ele, high: high, low: mid + 1)
		}
	}
	return "Can't find the element in the list."
}

// Reads information from input.txt
let contents = try String(contentsOfFile: "input.txt")
let dataArr = contents.components(separatedBy: "\n").filter { $0 != "" }

// Clears the file each time you run the program
let text = ""
do {
        try text.write(to: URL(fileURLWithPath: "output.txt"), atomically: false,
                                               encoding: .utf8)
} catch {
        print(error)
}

// Separates the arrays and elements into their own separate array
var elementArr = [Int]()
var originalArr = [[String]]()
var listArr = [[Int]]()

// Display the answer to output.txt as well as error messages
if let fileWriter = try? FileHandle(forUpdating: URL(fileURLWithPath: "output.txt")) {

	// Checks to see if the input.txt file is empty
	if dataArr.count == 0 {
        	fileWriter.write(("Please enter at least one number to input.txt").data(using: .utf8)!)
	} else {

		// Separates the arrays and elements into their own array and converts them into Int
		for val in 0..<dataArr.count {
			if val % 2 == 0 {
				originalArr.append(contentsOf: [dataArr[val].components(separatedBy: ",")])
				listArr.append(contentsOf: [dataArr[val].components(separatedBy: ",").compactMap {
									Int($0.trimmingCharacters(in: .whitespaces))}])
			} else {
				elementArr.append(Int(dataArr[val])!)
			}
		}

		// Implements binary search on each array
		for val in 0..<listArr.count {
			fileWriter.seekToEndOfFile()
			if listArr[val].count == originalArr[val].count {
                        	fileWriter.write((binarySearch(array: listArr[val], ele: elementArr[val],
						high: listArr.count - 1, low: 0) + "\n").data(using: .utf8)!)
			} else {
				fileWriter.write(("Please ensure that all values are integers." + "\n").data(using: .utf8)!)
			}
		}
	}
}
