class Hook
  def print_new_hook_message
    puts Paint["New #{type} hook created", :green]
  end

  def print_new_steps_message
    puts Paint[ "New steps added to #{type} hook\n#{steps}", :green]
  end

  def contents
    File.read(filepath)
  end

  def filepath
    File.join(".git", "hooks", type)
  end

  def create_file_if_does_not_exist
    unless Dir.glob(filepath).any?
      create_file
    end
  end

  def create_file
    %x[ touch #{filepath} ]
    %x[ chmod +x #{filepath} ]
    print_new_hook_message
  end

  def find_or_create
  end

  def write!
    unless contains_steps?
      File.open(filepath, "a") do |file|
        file.puts steps
      end
      print_new_steps_message
    end
  end

  def contains_steps?
    contents.include?(steps)
  end
end
