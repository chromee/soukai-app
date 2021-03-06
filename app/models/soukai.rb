class Soukai < ActiveRecord::Base
  has_secure_password
  validates :name,  presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_many :attendance, dependent: :destroy
  has_many :project, dependent: :destroy
  
  def Soukai.narrow_month(month)
    if Rails.env.development?
      Soukai.where("cast(strftime('%m', date) as int) = ?", month)
    else
      Soukai.where("extract(month from date) = ?", month)
    end
  end
  
  def Soukai.narrow_year(year)
    if Rails.env.development?
      Soukai.where("cast(strftime('%Y', date) as int) = ?", year).order("date desc")
    else
      Soukai.where("extract(year  from date) = ?", year).order("date desc")
    end
  end
    
end
