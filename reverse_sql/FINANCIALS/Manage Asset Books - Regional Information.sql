/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=FA_BOOK_CONTROLS
-- VALUE_SET_LOGIC_TO_APPLY_FIELDS=RES_FIELD_VALUE 
 
WITH EFF_STUCTURE AS ( SELECT valueSET.VALIDATION_TYPE,valueSET.VALUE_SET_CODE,EFF.CONTEXT_CODE,EFF.COLUMN_NAME,EFF.SEQUENCE_NUMBER,EFF.PROMPT
FROM FND_DF_SEGMENTS_VL EFF,FND_VS_VALUE_SETS valueSET 
WHERE EFF.VALUE_SET_ID = valueSET.VALUE_SET_ID AND EFF.ENABLED_FLAG = 'Y'
AND EFF.DESCRIPTIVE_FLEXFIELD_CODE = 'JGxFABookControls')

SELECT bookCONE0.BOOK_TYPE_CODE RES_NAME
,EFF_STUCTURE.PROMPT RES_FIELD_NAME
,(CASE WHEN EFF_STUCTURE.VALIDATION_TYPE = 'TABLE' THEN
	(CASE WHEN EFF_STUCTURE.VALUE_SET_CODE = 'JE_YES_NO' THEN
		DECODE(DECODE(EFF_STUCTURE.COLUMN_NAME
		,'GLOBAL_ATTRIBUTE1',bookCONE0.GLOBAL_ATTRIBUTE1
		,'GLOBAL_ATTRIBUTE2',bookCONE0.GLOBAL_ATTRIBUTE2
		,'GLOBAL_ATTRIBUTE3',bookCONE0.GLOBAL_ATTRIBUTE3
		,'GLOBAL_ATTRIBUTE4',bookCONE0.GLOBAL_ATTRIBUTE4
		,'GLOBAL_ATTRIBUTE5',bookCONE0.GLOBAL_ATTRIBUTE5
		,'GLOBAL_ATTRIBUTE6',bookCONE0.GLOBAL_ATTRIBUTE6
		,'GLOBAL_ATTRIBUTE7',bookCONE0.GLOBAL_ATTRIBUTE7
		,'GLOBAL_ATTRIBUTE8',bookCONE0.GLOBAL_ATTRIBUTE8
		,'GLOBAL_ATTRIBUTE9',bookCONE0.GLOBAL_ATTRIBUTE9
		,'GLOBAL_ATTRIBUTE10',bookCONE0.GLOBAL_ATTRIBUTE10
		,'GLOBAL_ATTRIBUTE11',bookCONE0.GLOBAL_ATTRIBUTE11
		,'GLOBAL_ATTRIBUTE12',bookCONE0.GLOBAL_ATTRIBUTE12
		,'GLOBAL_ATTRIBUTE13',bookCONE0.GLOBAL_ATTRIBUTE13
		,'GLOBAL_ATTRIBUTE14',bookCONE0.GLOBAL_ATTRIBUTE14
		,'GLOBAL_ATTRIBUTE15',bookCONE0.GLOBAL_ATTRIBUTE15
		,'GLOBAL_ATTRIBUTE16',bookCONE0.GLOBAL_ATTRIBUTE16
		,'GLOBAL_ATTRIBUTE17',bookCONE0.GLOBAL_ATTRIBUTE17
		,'GLOBAL_ATTRIBUTE18',bookCONE0.GLOBAL_ATTRIBUTE18
		,'GLOBAL_ATTRIBUTE19',bookCONE0.GLOBAL_ATTRIBUTE19
		,'GLOBAL_ATTRIBUTE20',bookCONE0.GLOBAL_ATTRIBUTE20),'Y','Yes','No')
	ELSE
		DECODE(EFF_STUCTURE.COLUMN_NAME
		,'GLOBAL_ATTRIBUTE1',
			(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE1 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE1) 
				END)
		,'GLOBAL_ATTRIBUTE2',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE2 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE2)
				END)
		,'GLOBAL_ATTRIBUTE3',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE3 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE3)
				END)
		,'GLOBAL_ATTRIBUTE4',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE4 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE4)
				END)
		,'GLOBAL_ATTRIBUTE5',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE5 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE5)
				END)
		,'GLOBAL_ATTRIBUTE6',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE6 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE6)
				END)
		,'GLOBAL_ATTRIBUTE7',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE7 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE7)
				END)
		,'GLOBAL_ATTRIBUTE8',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE8 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE8)
				END)
		,'GLOBAL_ATTRIBUTE9',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE9 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE9)
				END)
		,'GLOBAL_ATTRIBUTE10',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE10 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE10)
				END)
		,'GLOBAL_ATTRIBUTE11',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE11 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE11)
				END)
		,'GLOBAL_ATTRIBUTE12',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE12 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE12)
				END)
		,'GLOBAL_ATTRIBUTE13',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE13 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE13)
				END)
		,'GLOBAL_ATTRIBUTE14',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE14 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE14)
				END)
		,'GLOBAL_ATTRIBUTE15',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE15 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE15)
				END)
		,'GLOBAL_ATTRIBUTE16',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE16 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE16)
				END)
		,'GLOBAL_ATTRIBUTE17',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE17 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE17)
				END)
		,'GLOBAL_ATTRIBUTE18',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE18 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE18)
				END)
		,'GLOBAL_ATTRIBUTE19',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE19 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE19)
				END)
		,'GLOBAL_ATTRIBUTE20',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE20 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||bookCONE0.GLOBAL_ATTRIBUTE20)
				END)
		,'GLOBAL_ATTRIBUTE_NUMBER1',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE_NUMBER1 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||TO_CHAR(bookCONE0.GLOBAL_ATTRIBUTE_NUMBER1))
				END)
		,'GLOBAL_ATTRIBUTE_NUMBER2',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE_NUMBER2 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||TO_CHAR(bookCONE0.GLOBAL_ATTRIBUTE_NUMBER2))
				END)
		,'GLOBAL_ATTRIBUTE_NUMBER3',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE_NUMBER3 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||TO_CHAR(bookCONE0.GLOBAL_ATTRIBUTE_NUMBER3))
				END)
		,'GLOBAL_ATTRIBUTE_NUMBER4',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE_NUMBER4 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||TO_CHAR(bookCONE0.GLOBAL_ATTRIBUTE_NUMBER4))
				END)
		,'GLOBAL_ATTRIBUTE_NUMBER5',(CASE WHEN bookCONE0.GLOBAL_ATTRIBUTE_NUMBER5 IS NOT NULL THEN 
				(EFF_STUCTURE.VALUE_SET_CODE||'###R4C###'||TO_CHAR(bookCONE0.GLOBAL_ATTRIBUTE_NUMBER5))
				END)
			)
	END)
	ELSE
	DECODE(EFF_STUCTURE.COLUMN_NAME
	,'GLOBAL_ATTRIBUTE1',bookCONE0.GLOBAL_ATTRIBUTE1
	,'GLOBAL_ATTRIBUTE2',bookCONE0.GLOBAL_ATTRIBUTE2
	,'GLOBAL_ATTRIBUTE3',bookCONE0.GLOBAL_ATTRIBUTE3
	,'GLOBAL_ATTRIBUTE4',bookCONE0.GLOBAL_ATTRIBUTE4
	,'GLOBAL_ATTRIBUTE5',bookCONE0.GLOBAL_ATTRIBUTE5
	,'GLOBAL_ATTRIBUTE6',bookCONE0.GLOBAL_ATTRIBUTE6
	,'GLOBAL_ATTRIBUTE7',bookCONE0.GLOBAL_ATTRIBUTE7
	,'GLOBAL_ATTRIBUTE8',bookCONE0.GLOBAL_ATTRIBUTE8
	,'GLOBAL_ATTRIBUTE9',bookCONE0.GLOBAL_ATTRIBUTE9
	,'GLOBAL_ATTRIBUTE10',bookCONE0.GLOBAL_ATTRIBUTE10
	,'GLOBAL_ATTRIBUTE11',bookCONE0.GLOBAL_ATTRIBUTE11
	,'GLOBAL_ATTRIBUTE12',bookCONE0.GLOBAL_ATTRIBUTE12
	,'GLOBAL_ATTRIBUTE13',bookCONE0.GLOBAL_ATTRIBUTE13
	,'GLOBAL_ATTRIBUTE14',bookCONE0.GLOBAL_ATTRIBUTE14
	,'GLOBAL_ATTRIBUTE15',bookCONE0.GLOBAL_ATTRIBUTE15
	,'GLOBAL_ATTRIBUTE16',bookCONE0.GLOBAL_ATTRIBUTE16
	,'GLOBAL_ATTRIBUTE17',bookCONE0.GLOBAL_ATTRIBUTE17
	,'GLOBAL_ATTRIBUTE18',bookCONE0.GLOBAL_ATTRIBUTE18
	,'GLOBAL_ATTRIBUTE19',bookCONE0.GLOBAL_ATTRIBUTE19
	,'GLOBAL_ATTRIBUTE20',bookCONE0.GLOBAL_ATTRIBUTE20
	,'GLOBAL_ATTRIBUTE_NUMBER1',bookCONE0.GLOBAL_ATTRIBUTE_NUMBER1
	,'GLOBAL_ATTRIBUTE_NUMBER2',bookCONE0.GLOBAL_ATTRIBUTE_NUMBER2
	,'GLOBAL_ATTRIBUTE_NUMBER3',bookCONE0.GLOBAL_ATTRIBUTE_NUMBER3
	,'GLOBAL_ATTRIBUTE_NUMBER4',bookCONE0.GLOBAL_ATTRIBUTE_NUMBER4
	,'GLOBAL_ATTRIBUTE_NUMBER5',bookCONE0.GLOBAL_ATTRIBUTE_NUMBER5
	,'GLOBAL_ATTRIBUTE_DATE1',TO_CHAR(bookCONE0.GLOBAL_ATTRIBUTE_DATE1,'DD-Mon-YYYY')
	,'GLOBAL_ATTRIBUTE_DATE2',TO_CHAR(bookCONE0.GLOBAL_ATTRIBUTE_DATE2,'DD-Mon-YYYY')
	,'GLOBAL_ATTRIBUTE_DATE3',TO_CHAR(bookCONE0.GLOBAL_ATTRIBUTE_DATE3,'DD-Mon-YYYY')
	,'GLOBAL_ATTRIBUTE_DATE4',TO_CHAR(bookCONE0.GLOBAL_ATTRIBUTE_DATE4,'DD-Mon-YYYY')
	,'GLOBAL_ATTRIBUTE_DATE5',TO_CHAR(bookCONE0.GLOBAL_ATTRIBUTE_DATE5,'DD-Mon-YYYY'))
	END) RES_FIELD_VALUE
,bookCONE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,bookCONE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,bookCONE0.CREATED_BY RSC_CREATED_BY
,bookCONE0.CREATION_DATE RSC_CREATION_DATE
,PGL.PRIMARY_LEDGER_ID RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FA_BOOK_CONTROLS bookCONE0 
,EFF_STUCTURE
,(select RSHIP.TARGET_LEDGER_ID
	,RSHIP.PRIMARY_LEDGER_ID 
	from GL_LEDGER_RELATIONSHIPS RSHIP
	WHERE (RSHIP.RELATIONSHIP_TYPE_CODE <> 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'SECONDARY')
	OR (RSHIP.RELATIONSHIP_TYPE_CODE = 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'PRIMARY')) PGL
WHERE bookCONE0.SET_OF_BOOKS_ID = PGL.TARGET_LEDGER_ID
AND EFF_STUCTURE.CONTEXT_CODE = bookCONE0.GLOBAL_ATTRIBUTE_CATEGORY
AND (bookCONE0.GLOBAL_ATTRIBUTE_CATEGORY IS NOT NULL OR
bookCONE0.GLOBAL_ATTRIBUTE1 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE2 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE3 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE4 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE5 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE6 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE7 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE8 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE9 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE10 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE11 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE12 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE13 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE14 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE15 IS NOT NULL OR
bookCONE0.GLOBAL_ATTRIBUTE16 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE17 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE18 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE19 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE20 IS NOT NULL OR
bookCONE0.GLOBAL_ATTRIBUTE_NUMBER1 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE_NUMBER2 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE_NUMBER3 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE_NUMBER4 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE_NUMBER5 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE_DATE1 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE_DATE2 IS NOT NULL OR 
bookCONE0.GLOBAL_ATTRIBUTE_DATE3 IS NOT NULL OR
bookCONE0.GLOBAL_ATTRIBUTE_DATE4 IS NOT NULL OR
bookCONE0.GLOBAL_ATTRIBUTE_DATE5 IS NOT NULL )
	
 
ORDER BY 1,2