guard 'markdown', :convert_on_start => true, :dry_run => false do  
  watch (/README.md/) {|m| "README.md|./README.html"}
end

guard 'minitest' do
  watch(%r|^spec/(.*)_spec\.rb|)
  watch(%r|^lib/(.*)\.rb|)            { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r|^spec/spec_helper\.rb|)    { "spec" }
end
