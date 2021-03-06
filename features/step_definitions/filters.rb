Given /^I load a CSV table containing$/ do |string|
  @lines = string.split(/\n/)
end

When /^I numerically filter the table for$/ do |table|
  # table is a Cucumber::Ast::Table
  @table = table
end

Then /^I should have result$/ do
  @table.hashes.each do |h|
    p h
    result = eval(h['result'])
    options = { :in_format => :split, :split_on => ',' }
    options[:num_filter] = h['num_filter']
  
    p options
    p result
    t = BioTable::Table.new
    rownames,lines = t.read_lines(@lines, options)
    p lines
    lines.map {|r| r[1].to_i }.should == result
  end
end

When /^I filter the table for$/ do |table|
  # table is a Cucumber::Ast::Table
  @table1 = table
end

Then /^I should have filter result$/ do
  @table1.hashes.each do |h|
    p h
    result = eval(h['result'])
    options = { :in_format => :split, :split_on => ',' }
    options[:filter] = h['filter']
  
    p options
    p result
    t = BioTable::Table.new
    rownames,lines = t.read_lines(@lines, options)
    p lines
    lines.map {|r| r[1].to_i }.should == result
  end
end

