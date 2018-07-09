CREATE TABLE [iceCTI].[Grade] (
    [GradeID]                            INT      IDENTITY (1, 1) NOT NULL,
    [PhoneEn_NumhundledLessThanTarget]   INT      NULL,
    [PhoneFr_NumhundledLessThanTarget]   INT      NULL,
    [G2TEn_NumhundledLessThanTarget]     INT      NULL,
    [G2TFr_NumhundledLessThanTarget]     INT      NULL,
    [ChatEn_NumhundledLessThanTarget]    INT      NULL,
    [ChatFr_NumhundledLessThanTarget]    INT      NULL,
    [ChatAppEn_NumhundledLessThanTarget] INT      NULL,
    [ChatAppFr_NumhundledLessThanTarget] INT      NULL,
    [PhoneEn_NumOffered]                 INT      NULL,
    [PhoneFr_NumOffered]                 INT      NULL,
    [G2TEn_NumOffered]                   INT      NULL,
    [G2TFr_NumOffered]                   INT      NULL,
    [ChatEn_NumOffered]                  INT      NULL,
    [ChatFr_NumOffered]                  INT      NULL,
    [ChatAppEn_NumOffered]               INT      NULL,
    [ChatAppFr_NumOffered]               INT      NULL,
    [changedDate]                        DATETIME NULL,
    [CreatedDate]                        DATETIME CONSTRAINT [DF_grade_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_grade] PRIMARY KEY CLUSTERED ([GradeID] ASC)
);

