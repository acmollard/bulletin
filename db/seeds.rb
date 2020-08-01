# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

#SEEDS FOR THE DEMO VIDEO
#Re-organized existing seeds plus added new ones

#CREATING TAGS

["education", "children", "elderly", "environment", "sports", "health", "research", "activism", "animals", "fundraising/charity", "meal prep", "other"].each do |item|
    Tag.create(name: item)
end

opportunity_list = [
    [false, "Parktown Food Hub", "PARKTOWN FOOD HUB VOLUNTEER OPPORTUNITIES", true, "5123 Revere Road, Durham, NC, 27713", "Parktown Food Hub is currently seeking food distribution volunteers.   6-7 volunteers for each onsite distribution  (5123 Revere Road, Durham) and 3-4 people for offsite distributions.  Volunteer signup options are online through July! The times include the usual onsite distribution and general volunteer times, but we have also added a truck crew, a cleanup crew, and Gardening times on Saturdays.", "Sharon Schulze", "+1 984-484-8475", nil, 2.0, "Faith-based community partnership aimed at reducing hunger and food insecurity in South Durham, NC Our Mission: Feed as many people as possible with zero food waste. (Parktown Food Hub is a connectional outreach of South Durham Connections.)", nil, "984-484-8475", "parktownhub@gmail.com", "parktownhub@gmail.com"],

    [true, "El Centro Hispano, Inc", "TUTORING HISPANIC/LATINX CHILDREN", true, "2000 Chapel Hill Road, Durham, NC, 27703", "We need 15 volunteers for Tutoring, Mondays AND/OR Wednesdays from 4:30-5:30 PM. The location is El Centro Hispano of Carrboro-Chapel Hill, 2000 Chapel Hill Road, Suite 26A, Durham NC 27707. Intern’s responsibilities will include tutoring students in math and reading homework, communicating with parents about their students’ grades, identifying homework responsibilities for that day, helping students complete homework accurately, and conversing with parents/guardians to create positive learning environments at home. Interns will continue practicing Spanish to help Hispanic/Latinx children receive after school tutoring. Interested volunteers should contact Education Department Manager, Antonio Alanís at aalanis@elcentronc.org. Fall semesters will tentatively run from September 9 to December 4. Spring Semesters will run from January 13-April 29.

    To continue, fill the following Google Form https://bit.ly/2PD1IbM. The second step is to print a Volunteer Application, fill it out, and bring it next time that you come to tutoring. https://bit.ly/35Dge97", "Antonio Alanís", "9196874635, ext 133", "http://elcentronc.org/", 1.0, "El Centro Hispano is a Latino non-profit organization dedicated to strengthening the community, building bridges and advocating for equity and inclusion for Hispanics/Latinos in the Triangle area of North Carolina.", true, "9196874635", "aalanis@elcentronc.org", nil],

    [false, "Citizen Schools", "STEM CLASSROOM VOLUNTEERS", true, "4800 Old Chapel Hill Rd, Durham, NC, 27707", "VOLUNTEER WITH CITIZEN SCHOOLS IN DURHAM SPRING 2020

    Become a Catalyst STEM Volunteer!

    Help inspire students by bringing real-world relevance to learning and increase interest in STEM as a classroom Catalyst volunteer. The commitment is light: typically 1 hour a week for 2-3 weeks.

    Citizen Schools’ Catalyst program partners classroom teachers with industry professionals to deliver high-quality, project-based STEM learning experiences for middle school students during the school day. Volunteers work with students in small groups to research, build, and present a final product.

    We are currently recruiting volunteers to support projects in Metabolism and Climate Science at Projects begin in February, March, and April.

    Who Should Volunteer?

    Metabolism:

    Nutrition Health Science

    Public Health

    Biomedical engineering

    Biotechnology (other)

    Video editing

    Video production

    written communication

    oral communication (presentations)

     Climate Science:

    Civil engineering

    Environmental Monitoring

    Earth sciences

    Fabrication

    Programming

    Land use planning

    Research related to climate

    written communication

    oral communication (presentations)

    Volunteers who enjoy working with students do not have to be employed in these professions. We seek motivated volunteers who are willing to guide students from planning to presentation.

    What is the Volunteer commitment? You will visit visit a classroom 4-6 times over the course of a 4-week project, complete a short survey after their visits and final project feedback survey.



    What will I do as a Catalyst volunteer?

    You will share stories about your career pathway, work with teams of students to develop and improve their STEM projects and presentations, and connect with a network of other dedicated volunteers in your community.",
    "Patricia Corbett", "617-695-2300", "http://citizenschools.org/catalyst", 3.0, "Citizen Schools helps all students to thrive in school and beyond through hands-on learning and career mentors.
    Our vision is for all students to have experiences and career mentors that ignite curiosity, build confidence, and help them develop into the next generation of leaders.", nil, "617-695-2300", "patriciacorbett@citizenschools.org", "info@citizenschools.org"],

    [false, "Exchange Family Center", "PINWHEELS FAMILY FUN DAY", false, "715 N Hoover Rd., Durham, NC, 27703", "The Exchange Family Center (EFC) is excited to present the 7thAnnual Pinwheels Family Fun Day! When families spend time together, the interaction increases children’s social-emotional growth and strengthens family bonds. These are important factors in supporting children’s resilience and strengthening families-the very mission of EFC.

    Volunteers are needed to help make the event a success! If you’re looking for a fun volunteer opportunity at a family friendly event – this is for you.

    We are seeking volunteers to help staff our photo booth, registration, giveaway and raffle tables. We are also looking for assistance with event setup and cleanup. Volunteers will receive a t-shirt, snacks & beverages, a ticket for a giveaway, and free admission to enjoy the event before and/or after their shift! We ask that volunteers commit to a minimum of a two hour shift.

    Sign up for a volunteer shift at http://bit.ly/EFCPinwheelsVolunteer.", "Calvin Burton", "9193210657", "https://www.exchangefamilycenter.org/events/pinwheels", 4.0, "Exchange Family Center has been working for 26 years to better the live’s of children in Durham and to keep families together. We use a multi-prong approach — providing support and training for families, caregivers and childcare professionals, as well as working to raise community awareness. Anyone and everyone can play a part in creating safe and responsive environments for children.", true, "9193210657", "calvinb@exchangefamilycenter.org", nil],

    [false, "Bethesda Elementary School", "BETHESDA ELEMENTARY SCHOOL CAREER DAY ON NOV 22ND", false, "2009 South Miami Boulevard, Durham, NC, 27703", "We are looking for parents and community members who are willing to share information about their careers with our students on Friday November 22, 2019. Guest Speakers are asked to present sessions between the hours of 8:30am to 1:00pm.

    Complete the form below to confirm your participation in Bethesda’s Annual Career Day. Once you have completed the form, we will provide you with further information concerning our Career Day.", "Katina Hardiman", "(919) 560-3904", "https://docs.google.com/forms/d/e/1FAIpQLSeXqeQ3Hldvyd38vXhb_EX5IQdytKR2_S2UtlcMWO30kWkouw/viewform", 4.5, "Principal: Shaneeka Moore-Lawrence
    Enrollment : 702 (as of 6/8/18)
    Vision:
    Every day!  Every one!  Every way!
    Mission:
    We will learn, serve and achieve.", true, "(919) 560-3904", "Katina.Hardiman@dpsnc.net", nil],

    [false, "Carrboro Recreation & Parks Department","VOLUNTEER BASKETBALL COACHES", true, "100 N. Greensboro Street, Carrboro, NC, 27510", "Carrboro Recreation and Parks Department is accepting volunteer coach interest for the 2019 – 2020 Youth Basketball Program. Coaches must exhibit the ability to teach good sportsmanship and organize practices, prepare for games and communicate effectively with players, parents, and Recreation Department staff. Openings in the 6-8, 9-10, 13-15 age groups. For more information, please contact Craig Wolfe or cwolfe@townofcarrboro.org", "Craig Wolfe", "919-918-7376", "http://carrbororec.org/", 2.0, "The Carrboro Recreation, Parks, & Cultural Resources Department offers leisure programs and events along with eleven parks and one indoor facility.  The programs and events offered throughout the year range from instructional classes to athletic leagues to large community events, such as the Carrboro Music Festival.", true, "919-942-8541", "criley@townofcarrboro.org", "recParks@townofcarrboro.org"],

    [false, "The Scrap Exchange", "CREATIVE REUSE VOLUNTEER", true, "2050 Chapel Hill Road, Durham, NC, 27707", "We are seeking volunteers who can commit to a regular schedule to help us with general organizing around our reuse center. Projects include things like greeting customers, sorting, packaging, merchandising, store displays and organizing materials as well as general cleaning, sweeping, and tidying.

    Materials include fabric, sewing supplies, kids craft materials, fine art supplies, paper, office supplies, wood, tile, electronics, and much more. Volunteers may specialize in a particular area or help in a more broad sense.", "Tatyana Kasperovich", "9194010552", "http://scrapexchange.org/", 2.0, "The Scrap Exchange is a nonprofit organization with a mission to promote creativity, environmental awareness, and community through reuse.", false, "9194010552", "volunteer@scrapexchange.org", "volunteer@scrapexchange.org"],

    [true, "Cat Angels Pet Adoptions", "HELP CARE FOR THE CATS AND KITTENS AT OUR ADOPTION FACILITY", true, "959 North Harrison Avenue, Cary, NC, 27513", "Cat Angels Pet Adoptions is a no-kill, cat and kitten rescue shelter and adoption center in Cary, NC. Our cats and kittens are well-loved, and well-cared for in a loving home-like environment while they are waiting for their forever home. Come join us in giving them excellent care, including feeding, watering, scooping litter boxes, cleaning the cat rooms and taking out trash as well as giving our cats lots of love and playtime. Care shifts are available twice a day, in the morning or in the evening. Core morning hours are 9 to 11, evening shifts vary, some start as early as 4, others at 5 or 5:30. If interested, please complete the Volunteer Application on our website.", "Elizabeth Towns", "919-463-9586", "http://www.catangelsnc.org/", 4.0, "Cat Angels Pet Adoptions is a cat and kitten rescue and adoption organization and no-kill shelter in Cary, North Carolina. We are a 501(c)(3) public charity and our mission is to help homeless, abandoned, and/or abused cats and kittens find safe, loving, permanent homes, and reduce the number of unwanted pets destroyed at kill shelters.", true, "919-463-9586", "elizabethtownscatangels@gmail.com", "elizabethtownscatangels@gmail.com"],

    [false, "Duke GPSC Community Pantry", "DUKE GPSC COMMUNITY PANTRY", false, "306 Alexander Ave, Durham, NC, 27705", "The GPSC Community Pantry is now open to ALL Duke students, including undergraduates in need!  They are currently accepting the following item donations:

    Canned vegetables and fruits
    Rice, lentils, and pasta
    Cereal and oatmeal
    Baby care including food, diapers, and wipes
    Personal hygiene products
    Feminine hygiene products
    School supplies
    Gently used professional clothing
    Volunteers are also needed to staff a shift and help students, pack weekly bags, and stock shelves as well as to help out with a weekly shopping trip by picking up groceries from Harris Teeter.

    Hours: Wednesdays 5:00 – 8:00 PM, & Saturdays 3:00 – 6:00 PM", "Peter Pantry", "+1 (234)-567-8910", "http://dukegpsc.org/resources-for-students/community-pantry/", 0, "GPSC’s community pantry is open to all graduate and professional students and is located at the GPSC House (306 Alexander Ave), stocked with nonperishable foods, childcare items, school supplies, and gently used professional clothing.  A valid graduate or professional Duke student ID is required for entry.", nil, "+1 (234)-567-8910", "gpsc@duke.edu", "gpsc@duke.edu"],

    [false, "Playworks NC", "RECESS VOLUNTEER", true, "110 Corcoran Street, Durham, NC, 27701", "Playworks NC is a nonprofit based in Durham, NC with a presence in elementary schools within Rockingham, Wake, Durham counties. Within the schools we serve, we provide resources and training to build upon the social-emotional learning of students while incorporating conflict resolution skills through play.  We have multiple opportunities for those looking to volunteer with the youth of Durham. One can volunteer at recess with our AmeriCorp Coaches or at one of our community engagement events throughout the Spring. We would love it if any of those interested would get in contact with us to come out as be a helper on the playground with our coaches. The Program Manager Deshea Blake can give you specific opportunities based on your schedule. It can be a one time volunteer opportunity or ongoing. We look forward to seeing you volunteer.", "Deshea Blake", "919.419.6446", "https://www.playworks.org/north-carolina/", 2.0, "Playworks brings out the best in every kid, through play.
    We build a culture of play that enables kids to feel a real sense of belonging. Partnering with teachers, principals, and parents, we make sure kids have the opportunity to contribute on the playground, in the classroom, and in our community. A randomized control trial found that compared to students at similar schools, Playworks students were more physically active and teachers reported that students had greater feelings of school safety and less bullying behavior.", true, "919.419.6446", "deshea.blake@playworks.org", nil]
]

opportunity_list.each do |featured, org, oppname, on, loc, desc, name, phone, web, hours, orgdesc, approved, poc_phone, poc_email, org_email|
    org = Organization.create(
        name:org,
        website:web,
        phone:phone,
        description:orgdesc,
        approved:approved,
        email: org_email
    )
    opp = Opportunity.new(
        date:Faker::Date.forward(days: 30).to_time.to_i,
        ongoing:on,
        title:oppname,
        description:desc,
        volunteers_needed:Faker::Number.between(from: 0, to: 20),
        featured:featured,
        hours:hours,
        active:true,
        poc_name:name,
        poc_phone:poc_phone,
        poc_email:poc_email,
        likes:rand(0..15),
        created_at:Faker::Date.backward(days: 30)
    )
    add = Address.new(
        street:loc.split(", ")[0],
        city:loc.split(", ")[1],
        state:loc.split(", ")[2],
        zip:loc.split(", ")[3]
    )
    admin = OrgAdmin.create(
        name:name,
        phone:poc_phone,
        email:poc_email,
        password:Faker::Name.name,
        approved:approved
    )
    opp.address = add
    org.opportunities << opp
    org.save
    admin.organization = org
    admin.save
  end


  Opportunity.find(1).tags << Tag.find(2)
  Opportunity.find(1).tags << Tag.find(3)
  Opportunity.find(1).tags << Tag.find(11)

  Opportunity.find(2).tags << Tag.find(1)
  Opportunity.find(2).tags << Tag.find(2)

  Opportunity.find(3).tags << Tag.find(1)
  Opportunity.find(3).tags << Tag.find(2)
  
  Opportunity.find(4).tags << Tag.find(1)
  Opportunity.find(4).tags << Tag.find(2)
  Opportunity.find(4).tags << Tag.find(5)
  Opportunity.find(4).tags << Tag.find(10)

  Opportunity.find(5).tags << Tag.find(1)
  Opportunity.find(5).tags << Tag.find(2)

  Opportunity.find(6).tags << Tag.find(5)
  Opportunity.find(6).tags << Tag.find(6)

  Opportunity.find(7).tags << Tag.find(12)

  Opportunity.find(8).tags << Tag.find(8)

  Opportunity.find(9).tags << Tag.find(11)
  Opportunity.find(9).tags << Tag.find(6)

  Opportunity.find(10).tags << Tag.find(2)
  Opportunity.find(10).tags << Tag.find(5)
  Opportunity.find(10).tags << Tag.find(6)

  org = Organization.create(
    name:"Duke Office of Durham and Community Affairs",
    approved:true
  )

  org.save

  jen = OrgAdmin.create(
    name:"Jen Hubbard",
    email:"jen.hubbard@duke.edu",
    provider:"duke",
    uid:"jmh147",
    admin:true,
    password:1234567,
    approved:true
  )

  leslie = OrgAdmin.create(
    name:"Leslie Parkins",
    email:"leslie.parkins@duke.edu",
    provider:"duke",
    uid:"lcp34",
    admin:true,
    password:"1234567",
    approved:true
  )

  lindsey = OrgAdmin.create(
    name:"Lindsey Miller",
    email:"lindsey.miller@duke.edu",
    provider:"duke",
    uid:"lkm20",
    admin:true,
    password:"1234567",
    approved:true
  )

  domonique = OrgAdmin.create(
    name:"Domonique Redmond",
    email:"domonique.redmond@duke.edu",
    provider:"duke",
    uid:"dredmond",
    admin:true,
    password:"1234567",
    approved:true
  )

  josh = OrgAdmin.create(
    name:"Joshua Sauter",
    email:"joshua.sauter@duke.edu",
    provider:"duke",
    uid:"jds170",
    admin:true,
    password:"1234567",
    approved:true
  )

  braden = OrgAdmin.create(
    name:"Braden Hammond",
    email:"braden.hammond@duke.edu",
    provider:"duke",
    uid:"bmh58",
    admin:true,
    password:"1234567",
    approved:true
  )

  anna = OrgAdmin.create(
    name:"Anna Mollard",
    email:"anna.mollard@duke.edu",
    admin:true,
    password:"1234567",
    approved:true
  )

  zhichen = OrgAdmin.create(
    name:"Zhichen Guo",
    email:"zhichen.guo.liau@duke.edu",
    admin:true,
    password:"1234567",
    approved:true
  )

  jen.organization = org
  josh.organization = org
  domonique.organization = org
  lindsey.organization = org
  leslie.organization = org
  anna.organization = org
  zhichen.organization = org

  josh.address = Opportunity.last.address
  jen.address = Opportunity.last.address

  jen.save
  josh.save
  domonique.save
  lindsey.save
  leslie.save
  anna.save
  zhichen.save

# ["education", "tutor", "tech", "marketing", "ongoing", "5 miles away", "one-time", "outside", "bio", "math"].each do |item|
#     Tag.create(name:item)
# end

# =begin
# 10.times {
#     tag = Tag.create(name:Faker::Lorem.word)
# }
# =end

locs = Array["2000 Chapel Hill Road, Durham, NC, 27703", "5123 Revere Road, Durham, NC, 27713",
"4800 Old Chapel Hill Rd, Durham, NC, 27707", "715 N Hoover Rd., Durham, NC, 27703",
"2009 South Miami Boulevard, Durham, NC, 27703", "100 N. Greensboro Street, Carrboro, NC, 27510",
"2050 Chapel Hill Road, Durham, NC, 27707", "959 North Harrison Avenue, Cary, NC, 27513"]

# for i in locs
#     org = Organization.create(
#         name:Faker::Company.name,
#         description:Faker::Lorem.paragraph
#     )

#     rating = OrganizationRating.new(
#         rating:Faker::Number.between(from: 0, to: 5)
#     )
#     org.organization_ratings << rating

#     picture = Picture.new(
#         name:Faker::Name.name,
#         imageable_id:Faker::IDNumber.brazilian_citizen_number,
#         imageable_type:Faker::Lorem.word
#     )
#     org.pictures << picture

#     bool = true
#     if i[0].to_i<4
#         bool = false
#     end
#     opp = Opportunity.new(
#         date:Faker::Date.forward(days: 30).to_time.to_i,
#         ongoing:bool,
#         title:Faker::Lorem.words(number: 3).compact.join(' ').capitalize(),
#         location:i,
#         description:Faker::Lorem.paragraph,
#         volunteers_needed:Faker::Number.between(from: 0, to: 20),
#         requirements:Faker::Lorem.paragraph(sentence_count: 2),
#         preferences:Faker::Lorem.paragraph(sentence_count: 2),
#         hours:Faker::Number.between(from: 0, to: 10)
#     )

#     add = Address.new(
#         street:i.split(",")[0],
#         city:i.split(",")[1],
#         state:i.split(",")[2],
#         zip:i.split(",")[3],
#         locatable_id:Faker::IDNumber.brazilian_citizen_number,
#         locatable_type:"opportunity"
#     )
#     opp.address = add

#     org.opportunities << opp

#     rand(1..5).times do
#         opp.tags << Tag.where(id: rand(1..10))
#     end

#     org.save

#     user = User.create(
#         name:Faker::Name.name,
#         email:Faker::Internet.email,
#         phone:Faker::PhoneNumber.cell_phone,
#         car:Faker::Boolean.boolean,
#         password:Faker::Name.name
#     )

#     avail = Availability.new(
#         epoch_time:Faker::Time.between(from: DateTime.now - 1, to: DateTime.now).to_i
#     )
#     user.availabilities << avail

#     loc = Address.new(
#         street:"440 Chapel Drive",
#         city:"Durham",
#         state:"NC",
#         zip:27708,
#         locatable_id:Faker::IDNumber.brazilian_citizen_number,
#         locatable_type:"user"
#     )
#     user.address = loc

#     user.opportunities << opp

#     user_pic = Picture.new(
#         name:Faker::Name.name,
#         imageable_id:Faker::IDNumber.brazilian_citizen_number,
#         imageable_type:Faker::Lorem.word
#     )
#     user.pictures << user_pic

#     urate = UserRating.new(
#         rating:Faker::Number.between(from: 0, to: 5)
#     )
#     user.user_ratings << urate

#     user.save

#     admin = OrgAdmin.create(
#         name:Faker::Name.name,
#         email:Faker::Internet.email,
#         phone:Faker::PhoneNumber.cell_phone,
#         car:Faker::Boolean.boolean,
#         password:Faker::Name.name
#     )
#     admin.organizations << org

#     admin.save
# end

# Fake data for stat analysis
for i in 1..15
  user = User.create(
      name:Faker::Name.name,
      email:Faker::Internet.email,
      phone:Faker::PhoneNumber.cell_phone,
      car:Faker::Boolean.boolean,
      password:Faker::Name.name
  )

  user.save

  org = Organization.create(
        name:Faker::Company.name,
        description:Faker::Lorem.paragraph,
        email:Faker::Internet.email,
        approved:true
  )

  org.save

  for j in locs
      opp = Opportunity.new(
          date:Faker::Date.backward(days: 365).to_time.to_i,
          ongoing:0,
          title:Faker::Lorem.words(number: 3).compact.join(' ').capitalize(),
          location:j,
          description:Faker::Lorem.paragraph,
          volunteers_needed:Faker::Number.between(from: 0, to: 20),
          requirements:Faker::Lorem.paragraph(sentence_count: 2),
          preferences:Faker::Lorem.paragraph(sentence_count: 2),
          hours:Faker::Number.between(from: 0, to: 10),
          active:0
      )

      org.opportunities << opp

      for k in 1..3
        archived = ArchivedOpportunity.new(
          title:opp.title,
          date:opp.date,
          hours:Faker::Number.between(from: 0, to: 10),
          organization:org.name
        )

        opp.archived_opportunities << archived
        user.archived_opportunities << archived
        archived.save
      end

      opp.tags << Tag.find(Faker::Number.between(from: 1, to: 12))
  end
end

for i in [1, 3, 9]
  user = Organization.find(i).users.first

  org = Organization.find(i)

  admins = User.where(admin: true)
  admins.each do |admin|
    Notification.create(recipient: admin, actor: user, action: "wants_to_join_your_platform", notifiable: org)
  end
end
