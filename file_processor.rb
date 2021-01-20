# frozen_string_literal: true

class FileProcessor
  attr_reader :file

  def initialize(file)
    @file = File.open(file, 'r')
  end

  def process
    company = Company.new
    file_data.each do |row|
      RowProcessor.new(row.strip, company).process
    end
    file.close
    company
  end

  private

  def file_data
    @file_data ||= File.readlines(file)
  end
end
