USE [HelpdeskDb]
GO
/****** Object:  Table [dbo].[Settings]    Script Date: 11/05/2023 11:59:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Settings](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[company_name] [varchar](120) NULL,
	[address] [varchar](80) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](50) NULL,
	[zipcode] [varchar](50) NULL,
	[country] [varchar](50) NULL,
	[telephone] [varchar](50) NULL,
	[alternate_phone] [varchar](50) NULL,
	[facsimile] [varchar](50) NULL,
	[hours_of_operation] [varchar](255) NULL,
	[website] [varchar](120) NULL,
 CONSTRAINT [PK_Settings] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Complaints]    Script Date: 11/05/2023 11:59:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Complaints](
	[ComplaintId] [int] IDENTITY(1,1) NOT NULL,
	[reviewed_date] [datetime] NULL,
	[ticket_number] [varchar](50) NULL,
	[problems] [varchar](max) NULL,
	[active] [bit] NULL,
 CONSTRAINT [PK_Complaints] PRIMARY KEY CLUSTERED 
(
	[ComplaintId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/05/2023 11:59:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[userId] [int] IDENTITY(100,1) NOT NULL,
	[name] [varchar](50) NULL,
	[user_name] [varchar](255) NULL,
	[login_access] [varchar](255) NULL,
	[roles] [varchar](50) NULL,
	[active] [bit] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 11/05/2023 11:59:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tickets](
	[ID] [int] IDENTITY(1000,1) NOT NULL,
	[date_submitted] [datetime] NULL,
	[business_name] [varchar](50) NULL,
	[business_phone] [varchar](50) NULL,
	[business_location] [varchar](50) NULL,
	[contact_person] [varchar](50) NULL,
	[contact_email] [varchar](50) NULL,
	[priority] [varchar](50) NULL,
	[category] [varchar](50) NULL,
	[assigned] [bit] NULL,
	[ticket_number] [varchar](50) NULL,
	[status] [varchar](50) NULL,
 CONSTRAINT [PK_Tickets] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[spInsertUpdateUsers]    Script Date: 11/05/2023 11:59:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertUpdateUsers]
 @userId int,
 @name varchar(80),
 @username varchar(255),
 @loginaccess varchar(255),
 @roles varchar(50),
 @active bit,
 @nextId int OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF NOT EXISTS(select * from Users where user_name=@username)
	   BEGIN
			INSERT INTO [Users]
			    ([name]
				,[user_name]
				,[login_access]
				,[roles]
				,[active])
			VALUES
			    (@name
				,@username
				,@loginaccess
				,@roles
				,@active)
				SELECT @nextId=SCOPE_IDENTITY() 
      END
  ELSE
     BEGIN
		UPDATE [Users]
		SET [name] = @name			
			,[login_access] = @loginaccess
			,[roles] = @roles
			,[active] = @active
		WHERE [userId]=@userId
		--- Default to ID
	    SELECT @nextId=@userId
     END      				
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertUpdateTickets]    Script Date: 11/05/2023 11:59:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertUpdateTickets]
	@ID int,
	@businessname varchar(50),
	@businessphone varchar(50),
	@businesslocation varchar(50),
	@contactperson varchar(50),
	@contactemail varchar(120),
	@priority varchar(50),
	@category varchar(50),
	@assigned bit,
	@ticketnumber varchar(80),
	@status varchar(50),
	@nextId int OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF NOT EXISTS(select * from Tickets where ticket_number=@ticketnumber)
       BEGIN
		 INSERT INTO [dbo].[Tickets]
				([date_submitted]
				,[business_name]
				,[business_phone]
				,[business_location]
				,[contact_person]
				,[contact_email]
				,[priority]
				,[category]
				,[assigned]
				,[ticket_number]
				,[status])
		VALUES
			    (GETDATE()
				,@businessname
				,@businessphone
				,@businesslocation
				,@contactperson
				,@contactemail
				,@priority
				,@category
				,@assigned
				,@ticketnumber
				,@status)
				SELECT @nextId=SCOPE_IDENTITY() 
	  END           
  ELSE
     BEGIN
         UPDATE [dbo].[Tickets]
		 SET [business_name] = @businessname
			,[business_phone] = @businessphone
			,[business_location] = @businesslocation
			,[contact_person] = @contactperson
			,[contact_email] = @contactemail
			,[priority] = @priority
			,[category] = @category
			,[assigned] = @assigned
			,[ticket_number] = @ticketnumber
			,[status] = @status
		WHERE [ID]=@ID
		--- Default to ID
	    SELECT @nextId=@ID
     END	  
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertUpdateComplaints]    Script Date: 11/05/2023 11:59:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertUpdateComplaints]
  @ID int,
  @reviewedate datetime,
  @ticketnumber varchar(80),
  @problem varchar(max),
  @active bit,
  @nextId int OUTPUT	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF NOT EXISTS(select * from Complaints where ticket_number=@ticketnumber)
       BEGIN
			INSERT INTO [dbo].[Complaints]
				([reviewed_date]
				,[ticket_number]
				,[problems]
				,[active])
			VALUES
				(@reviewedate
				,@ticketnumber
				,@problem
				,@active)
				SELECT @nextId=SCOPE_IDENTITY() 
	   END          
	ELSE
	   BEGIN
	      UPDATE [dbo].[Complaints]
	  	  SET [reviewed_date] = @reviewedate
		 	 ,[ticket_number] = @ticketnumber
			 ,[problems] = @problem
			 ,[active] = @active
		  WHERE [ComplaintId]=@ID
		  --- Default to ID
	    SELECT @nextId=@ID
	  END
	     
END
GO
/****** Object:  StoredProcedure [dbo].[spInserteUpdateSettings]    Script Date: 11/05/2023 11:59:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInserteUpdateSettings]
	@ID int,
	@company varchar(120),
	@address varchar(80),
	@city varchar(50),
	@state varchar(10),
	@zip varchar(10),
	@country varchar(50),
	@phone varchar(15),
	@alternate varchar(15),
	@fax varchar(15),
	@hop varchar(512),
	@website varchar(255),
	@NextId int OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF NOT EXISTS(select * from Settings where company_name=@company and telephone=@phone)
       BEGIN
		INSERT INTO [Settings]
		        ([company_name]
			    ,[address]
				,[city]
				,[state]
				,[zipcode]
				,[country]
				,[telephone]
				,[alternate_phone]
				,[facsimile]
				,[hours_of_operation]
				,[website])
		VALUES
			    (@company
				,@address
				,@city
				,@state
				,@zip
				,@country
				,@phone
				,@alternate
				,@fax
				,@hop
				,@website)				
				SELECT @nextId=SCOPE_IDENTITY() 	
     END  
   ELSE
      BEGIN
		UPDATE [Settings]
		SET [company_name] = @company
			,[address] = @address
			,[city] = @city
			,[state] = @state
			,[zipcode] = @zip
			,[country] = @country
			,[telephone] = @phone
			,[alternate_phone] = @alternate
			,[facsimile] = @fax
			,[hours_of_operation] = @hop
			,[website] = @website
		WHERE [ID]=@ID
		--- Default to ID
	    SELECT @NextId=@ID
     END         
   
END
GO
/****** Object:  StoredProcedure [dbo].[spGetTicketData]    Script Date: 11/05/2023 11:59:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetTicketData]
  @TicketId int	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @TicketId>0 
	   BEGIN
	      SELECT [ID],[date_submitted],[business_name],[business_phone],[business_location],[contact_person],[contact_email],
			       [priority],[category],[assigned],[ticket_number],[status] FROM Tickets 
		  WHERE ID=@TicketId
	   END
    ELSE
	   BEGIN
			SELECT [ID],[date_submitted],[business_name],[business_phone],[business_location],[contact_person],[contact_email],
			       [priority],[category],[assigned],[ticket_number],[status] FROM Tickets
	   END
END
GO
/****** Object:  StoredProcedure [dbo].[spDeleteTicket]    Script Date: 11/05/2023 11:59:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteTicket]
  @TicketId int
AS
BEGIN
	DECLARE @TickekNumber varchar(50)
	SELECT @TickekNumber=ticket_number FROM Tickets WHERE [ID]=@TicketId
	SET NOCOUNT ON;
    
    DELETE FROM Complaints WHERE ticket_number=@TickekNumber    
    DELETE FROM Tickets WHERE ID=@TicketId 
    
END
GO
