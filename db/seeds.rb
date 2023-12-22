table_names =  %w(administrators customers owners salons stylists votes shifts courses)
table_names.each do |table_name|
    path = Rails.root.join("db/seeds",Rails.env,table_name+".rb")
    if File.exist?(path)
        puts "Creating #{table_name}..."
        #puts "pathは#{path}"
        require path
    end
end