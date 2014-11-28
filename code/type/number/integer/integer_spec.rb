describe "integer" do
  word_dir = Dir.pwd
  Dir.foreach(word_dir) do |e|
    next if e =="." || e == ".."
    path = File.join(word_dir, e)
    if FileTest.directory?(path)
      it "display integer #{e}" do
        Dir.chdir(path)
        run_result = `./run.sh 2>&1`
        expect(run_result).to eq("a = 24\nb = -24\n")
        Dir.chdir(word_dir)
      end
    end
  end
end
