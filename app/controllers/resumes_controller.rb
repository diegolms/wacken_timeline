require 'csv'

class ResumesController < ApplicationController

	BANDA = 0
	PALCO = 1
	DIAI = 2
	INICO = 3
	DIAF = 4
	FIM = 5
	MB = 6
	

 def index
      @resumes = Resume.all
   end
   
   def new
      @resume = Resume.new
   end
   
   def create
      @resume = Resume.new(resume_params)
      
      if @resume.save
         redirect_to resumes_path, notice: "The resume #{@resume.name} has been uploaded."
      else
         render "new"
      end
      
   end
   
   def destroy
      @resume = Resume.find(params[:id])
      @resume.destroy
      redirect_to resumes_path, notice:  "The resume #{@resume.name} has been deleted."
   end
   
   def timeline
         
   end
   
   def listar_horarios
		filename = File.dirname(File.dirname(File.expand_path(__FILE__))) + '/data/bandas.csv'
		cont = 0
		bandasSemHorario = []
		horasDisponiveis = []
		bandas = []
		
		CSV.foreach(filename) do |row|
		if cont == 0
			cont = cont +1
			next
		end		
		  linha = row[0].split(";")
		  if linha[PALCO].nil? 
			bandasSemHorario << linha[BANDA]
		  else
         #bandas << linha
         dia = DateTime.parse(linha[DIAI]+","+linha[INICO])
			dataInicio = DateTime.parse("2019-08-01"+","+linha[INICO])
			dataFim = DateTime.parse("2019-08-01"+","+linha[FIM])
         dataFim = dataFim <  dataInicio ? dataFim + 1.day : dataFim
         
         p " #{linha[BANDA]} - #{dataInicio} -  #{dataFim} - #{dia.wday} "

			bandas.push(
            {
                :banda => linha[BANDA],
                :palco => linha[PALCO],
                :dataInicio => dataInicio,
                :dataFim => dataFim,
                :mb => linha[MB],
                :dia => dia.wday
            }
        )

        
		  end
		  
		end

		
		render :json => {:bandasSemHorario => bandasSemHorario, :bandas => bandas}	
   end
   
   private
      def resume_params
      params.require(:resume).permit(:name, attachments: [])

   end
   
end
