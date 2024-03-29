USE dbTeste
GO

CREATE TABLE dbo.tbcliente_fone(
	[CLIENTE_ID] [bigint] NOT NULL,
	[FONE] [varchar](11) NOT NULL,
	[DATA_INCLUSAO] [smalldatetime] NOT NULL,
	[OBSE] [varchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[CLIENTE_ID] ASC,
	[FONE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tbcliente_fone]  WITH CHECK ADD FOREIGN KEY([CLIENTE_ID])
REFERENCES [dbo].[tbcliente] ([CLIENTE_ID]) ON DELETE CASCADE;
GO

CREATE TRIGGER tgAfterInsert_tbClienteFone ON tbCliente_fone
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE TBCLIENTE_FONE SET DATA_INCLUSAO = GETDATE()
     WHERE CLIENTE_ID IN (SELECT CLIENTE_ID FROM INSERTED)
	   AND FONE IN (SELECT FONE FROM INSERTED)
END;
GO

ALTER TABLE [dbo].[tbCliente_fone] ENABLE TRIGGER [tgAfterInsert_tbClienteFone];

