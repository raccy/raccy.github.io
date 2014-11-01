describe "hello" do
  word_dir = Dir.pwd
  Dir.foreach(word_dir) do |e|
    next if e =="." || e == ".."
    path = File.join(word_dir, e)
    if FileTest.directory?(path)
      it "display hello #{e}" do
        Dir.chdir(path)
        run_result = `./run.sh 2>&1`
        expect(run_result).to eq("こんにちは、世界！\n")
        Dir.chdir(word_dir)
      end
    end
  end
end
