get '/' do
  erb :index
end

post '/poem' do
  if request.xhr?
    text = params[:text]
    p text
    text.split(" ").map {|word| "<span class='#{word.downcase}'>#{word}</span>"}.join(" ")
  end
end

get '/rhymes' do
  if request.xhr?
    query_word = params[:word]
    text = params[:text].downcase
    text.split(" ").select { |word| Word.rhymes?(word, query_word) }.join("|")
  end
end