  class User < ApplicationRecord
    
    validates :phone, presence: true
    validate :valid_phone_number
    validates :email, presence: true, uniqueness: { message: "já está cadastrado" }
    validates_email_format_of :email, message: 'não é um e-mail válido'
    validate :cpf_format_and_validity
    validates :cpf,  uniqueness: { message: "já está cadastrado" }


    # verifica se o cpf tem tamanho correto e usa a valid_cpf para verificar se tem apenas numeros
    def cpf_format_and_validity
      if cpf.length != 11 || valid_cpf?(cpf) == false
        errors.add(:cpf, "não é um CPF válido")
      end
    end

    # verifica se tem apenas numeros
    def valid_cpf?(cpf)
      # Remova caracteres não numéricos
      cpf = cpf.gsub(/[^0-9]/, '')
      # compara o tamanho resultante com o que deferia ser
      if cpf.length != 11
        return false
      else
        return true
      end
    end

    #validar o numero de telefone
    def valid_phone_number
      unless Phonelib.valid?(phone)
        errors.add(:phone, "deve ser um número de telefone válido, contendo dd e '9'")
      end
    end

    #exibir o numreo de maneira formatada
    def format_phone_number
       # retorna phone formatado
        return formatted_phone = "(#{phone[0..1]}) #{phone[2]} #{phone[3..6]}-#{phone[7..10]}"
    end

    def format_cpf
      #retorna o cpf formatado
      return formatted_cpf = "#{cpf[0..2]}.#{cpf[3..5]}.#{cpf[6..8]}-#{cpf[9..10]}"
    end 

  end