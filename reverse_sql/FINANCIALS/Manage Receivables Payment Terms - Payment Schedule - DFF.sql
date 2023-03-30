/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receivables%20Payment%20Terms%20-%20Payment%20Schedule%20-%20DFF.sql $:
 * $Id: Manage Receivables Payment Terms - Payment Schedule - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=222##RES##RA_TERMS_LINES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select 
RaTermsVl.NAME RES_PAYMENT_TERMS_SET
,(SELECT SET_NAME FROM FUSION.FND_SETID_SETS_VL WHERE SET_ID = RATERMSVL.SET_ID ) RES_NAME
,RaTermsLines.SEQUENCE_NUM RES_SEQUENCE
,RaTermsLines.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,RaTermsLines.ATTRIBUTE1 
,RaTermsLines.ATTRIBUTE2
,RaTermsLines.ATTRIBUTE3
,RaTermsLines.ATTRIBUTE4
,RaTermsLines.ATTRIBUTE5
,RaTermsLines.ATTRIBUTE6
,RaTermsLines.ATTRIBUTE7
,RaTermsLines.ATTRIBUTE8
,RaTermsLines.ATTRIBUTE9
,RaTermsLines.ATTRIBUTE10
,RaTermsLines.ATTRIBUTE11
,RaTermsLines.ATTRIBUTE12
,RaTermsLines.ATTRIBUTE13
,RaTermsLines.ATTRIBUTE14
,RaTermsLines.ATTRIBUTE15
,RaTermsLines.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,RaTermsLines.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,RaTermsLines.CREATED_BY  RSC_CREATED_BY
,RaTermsLines.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM FUSION.RA_TERMS_VL RATERMSVL,
FUSION.RA_TERMS_LINES RATERMSLINES
WHERE 
(RaTermsLines.ATTRIBUTE_CATEGORY IS NOT NULL OR
RaTermsLines.ATTRIBUTE1 IS NOT NULL OR 
RaTermsLines.ATTRIBUTE2 IS NOT NULL OR 
RaTermsLines.ATTRIBUTE3 IS NOT NULL OR 
RaTermsLines.ATTRIBUTE4 IS NOT NULL OR 
RaTermsLines.ATTRIBUTE5 IS NOT NULL OR 
RaTermsLines.ATTRIBUTE6 IS NOT NULL OR 
RaTermsLines.ATTRIBUTE7 IS NOT NULL OR 
RaTermsLines.ATTRIBUTE8 IS NOT NULL OR 
RaTermsLines.ATTRIBUTE9 IS NOT NULL OR 
RaTermsLines.ATTRIBUTE10 IS NOT NULL OR 
RaTermsLines.ATTRIBUTE11 IS NOT NULL OR 
RaTermsLines.ATTRIBUTE12 IS NOT NULL OR 
RaTermsLines.ATTRIBUTE13 IS NOT NULL OR 
RaTermsLines.ATTRIBUTE14 IS NOT NULL OR 
RaTermsLines.ATTRIBUTE15 IS NOT NULL)
and RATERMSVL.TERM_ID = RATERMSLINES.TERM_ID 
AND RATERMSVL.SET_ID = RATERMSLINES.SET_ID 
order by RES_NAME, RES_SEQUENCE

/*SELECT distinct QRSLT.SETNAME  RES_PAYMENT_TERMS_SET
	   ,QRSLT.NAME 	RES_NAME
       ,QRSLT.SEQUENCE_NUM RES_SEQUENCE
       , DFF.FIELD_NAME RES_FIELD_NAME
	   , DFF.FIELD_VALUE RES_FIELD_VALUE
       ,null mapper
       ,QRSLT.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
       ,QRSLT.last_update_date  as RSC_LAST_UPDATE_DATE
from 
(SELECT 
   RaTermsVl.NAME,
  (SELECT SET_NAME FROM FUSION.FND_SETID_SETS_VL WHERE SET_ID = RATERMSVL.SET_ID ) AS SETNAME,  
  RaTermsLines.TERM_ID,  
  RaTermsLines.CREATED_BY,  
  RaTermsLines.DUE_DATE,
  RaTermsLines.DUE_DAY_OF_MONTH,
  RaTermsLines.DUE_DAYS,
  RaTermsLines.DUE_MONTHS_FORWARD,
  RaTermsLines.LAST_UPDATE_DATE,  
  RaTermsLines.LAST_UPDATED_BY,  
  RaTermsLines.RELATIVE_AMOUNT,
  RaTermsLines.SEQUENCE_NUM,
  RATERMSLINES.SET_ID
FROM FUSION.RA_TERMS_VL RATERMSVL,
FUSION.RA_TERMS_LINES RATERMSLINES
WHERE RATERMSVL.TERM_ID = RATERMSLINES.TERM_ID 
AND RATERMSVL.SET_ID = RATERMSLINES.SET_ID 
) QRSLT 
, TABLE(FUSION_READONLY.##RES_PLSQL_PACKAGE_NAME##.GET_DFF(P_APPLICATION_ID => 222
																			  ,P_DFF_CODE => 'RA_TERMS_LINES'
																			  ,P_BASE_TABLE => 'RA_TERMS_LINES'
																			  ,P_PK_COLUMN_1 => 'TERM_ID'
																			  ,P_PK_COLUMN_2 => 'SEQUENCE_NUM'																			  
	)) DFF
where DFF.FIELD_VALUE                     IS NOT NULL
AND  QRSLT.TERM_ID = TO_NUMBER(DFF.COL_1)
AND  QRSLT.SEQUENCE_NUM = TO_NUMBER(DFF.COL_2)
and (QRSLT.last_updated_by ##LAST_UPDATED_BY_OPERATOR## (##USER_NAME_LIST##)  AND QRSLT.last_update_date ##LAST_UPDATE_DATE_OPERATOR##  to_date('##SEEDED_DATE##'))
order by QRSLT.NAME, QRSLT.SEQUENCE_NUM*/