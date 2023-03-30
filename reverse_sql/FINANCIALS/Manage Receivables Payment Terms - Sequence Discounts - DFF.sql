/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receivables%20Payment%20Terms%20-%20Sequence%20Discounts%20-%20DFF.sql $:
 * $Id: Manage Receivables Payment Terms - Sequence Discounts - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=222##RES##RA_TERMS_LINES_DISCOUNTS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select 
RaTermsVl.NAME RES_PAYMENT_TERMS_SET
,(SELECT SET_NAME FROM FUSION.FND_SETID_SETS_VL WHERE SET_ID = RATERMSVL.SET_ID ) RES_NAME
,RaTermsLines.SEQUENCE_NUM RES_SEQUENCE
,(CASE
	WHEN RaTermsLinesDiscounts.DISCOUNT_PERCENT < 1 THEN
		'0'||replace(to_char(RaTermsLinesDiscounts.DISCOUNT_PERCENT,'9,999.99'),' ',null)
	ELSE
		replace(to_char(RaTermsLinesDiscounts.DISCOUNT_PERCENT,'9,999.99'),' ',null)
	END) RES_PERCENTAGE
,RaTermsLinesDiscounts.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,RaTermsLinesDiscounts.ATTRIBUTE1 
,RaTermsLinesDiscounts.ATTRIBUTE2
,RaTermsLinesDiscounts.ATTRIBUTE3
,RaTermsLinesDiscounts.ATTRIBUTE4
,RaTermsLinesDiscounts.ATTRIBUTE5
,RaTermsLinesDiscounts.ATTRIBUTE6
,RaTermsLinesDiscounts.ATTRIBUTE7
,RaTermsLinesDiscounts.ATTRIBUTE8
,RaTermsLinesDiscounts.ATTRIBUTE9
,RaTermsLinesDiscounts.ATTRIBUTE10
,RaTermsLinesDiscounts.ATTRIBUTE11
,RaTermsLinesDiscounts.ATTRIBUTE12
,RaTermsLinesDiscounts.ATTRIBUTE13
,RaTermsLinesDiscounts.ATTRIBUTE14
,RaTermsLinesDiscounts.ATTRIBUTE15
,RaTermsLinesDiscounts.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,RaTermsLinesDiscounts.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,RaTermsLinesDiscounts.CREATED_BY  RSC_CREATED_BY
,RaTermsLinesDiscounts.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM FUSION.RA_TERMS_VL RATERMSVL,
FUSION.RA_TERMS_LINES RATERMSLINES,
FUSION.RA_TERMS_LINES_DISCOUNTS RaTermsLinesDiscounts
WHERE 
(RaTermsLinesDiscounts.ATTRIBUTE_CATEGORY IS NOT NULL OR
RaTermsLinesDiscounts.ATTRIBUTE1 IS NOT NULL OR 
RaTermsLinesDiscounts.ATTRIBUTE2 IS NOT NULL OR 
RaTermsLinesDiscounts.ATTRIBUTE3 IS NOT NULL OR 
RaTermsLinesDiscounts.ATTRIBUTE4 IS NOT NULL OR 
RaTermsLinesDiscounts.ATTRIBUTE5 IS NOT NULL OR 
RaTermsLinesDiscounts.ATTRIBUTE6 IS NOT NULL OR 
RaTermsLinesDiscounts.ATTRIBUTE7 IS NOT NULL OR 
RaTermsLinesDiscounts.ATTRIBUTE8 IS NOT NULL OR 
RaTermsLinesDiscounts.ATTRIBUTE9 IS NOT NULL OR 
RaTermsLinesDiscounts.ATTRIBUTE10 IS NOT NULL OR 
RaTermsLinesDiscounts.ATTRIBUTE11 IS NOT NULL OR 
RaTermsLinesDiscounts.ATTRIBUTE12 IS NOT NULL OR 
RaTermsLinesDiscounts.ATTRIBUTE13 IS NOT NULL OR 
RaTermsLinesDiscounts.ATTRIBUTE14 IS NOT NULL OR 
RaTermsLinesDiscounts.ATTRIBUTE15 IS NOT NULL)
and RATERMSVL.TERM_ID = RATERMSLINES.TERM_ID 
AND RATERMSVL.SET_ID = RATERMSLINES.SET_ID 
and RATERMSLINES.TERM_ID    =  RaTermsLinesDiscounts.TERM_ID
AND RATERMSLINES.SEQUENCE_NUM = RATERMSLINESDISCOUNTS.SEQUENCE_NUM
AND RATERMSLINES.SET_ID       = RaTermsLinesDiscounts.SET_ID
order by RES_NAME, RES_SEQUENCE
 
/* SELECT QRSLT.SETNAME  RES_PAYMENT_TERMS_SET
	   ,QRSLT.NAME 	RES_NAME
       ,QRSLT.SEQUENCE_NUM RES_SEQUENCE
       ,replace(to_char(QRSLT.DISCOUNT_PERCENT,'9,999.99'),' ',null) RES_PERCENTAGE
       , DFF.FIELD_NAME RES_FIELD_NAME
	   , DFF.FIELD_VALUE RES_FIELD_VALUE
       ,null mapper
       ,QRSLT.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
       ,QRSLT.last_update_date  as RSC_LAST_UPDATE_DATE
from 
(SELECT 
   RaTermsVl.NAME,
  (SELECT SET_NAME FROM FUSION.FND_SETID_SETS_VL WHERE SET_ID = RATERMSVL.SET_ID ) AS SETNAME, 
  RATERMSLINES.SEQUENCE_NUM,  
   RaTermsLinesDiscounts.TERMS_LINES_DISCOUNT_ID,  
  RaTermsLinesDiscounts.CREATED_BY, 
  RaTermsLinesDiscounts.DISCOUNT_DATE,
  RaTermsLinesDiscounts.DISCOUNT_DAY_OF_MONTH,
  RaTermsLinesDiscounts.DISCOUNT_DAYS,
  RaTermsLinesDiscounts.DISCOUNT_MONTHS_FORWARD,
  RaTermsLinesDiscounts.DISCOUNT_PERCENT,
  RaTermsLinesDiscounts.LAST_UPDATE_DATE,  
  RaTermsLinesDiscounts.LAST_UPDATED_BY  
FROM FUSION.RA_TERMS_VL RATERMSVL,
FUSION.RA_TERMS_LINES RATERMSLINES,
FUSION.RA_TERMS_LINES_DISCOUNTS RaTermsLinesDiscounts
WHERE RATERMSVL.TERM_ID = RATERMSLINES.TERM_ID 
AND RATERMSVL.SET_ID = RATERMSLINES.SET_ID 
and RATERMSLINES.TERM_ID    =  RaTermsLinesDiscounts.TERM_ID
AND RATERMSLINES.SEQUENCE_NUM = RATERMSLINESDISCOUNTS.SEQUENCE_NUM
AND RATERMSLINES.SET_ID       = RaTermsLinesDiscounts.SET_ID
) QRSLT 
, TABLE(FUSION_READONLY.##RES_PLSQL_PACKAGE_NAME##.GET_DFF(P_APPLICATION_ID => 222
																			  ,P_DFF_CODE => 'RA_TERMS_LINES_DISCOUNTS'
																			  ,P_BASE_TABLE => 'RA_TERMS_LINES_DISCOUNTS'
																			  ,P_PK_COLUMN_1 => 'TERMS_LINES_DISCOUNT_ID'																		  
	)) DFF
where DFF.FIELD_VALUE                     IS NOT NULL
AND  QRSLT.TERMS_LINES_DISCOUNT_ID = TO_NUMBER(DFF.COL_1)
and (QRSLT.last_updated_by ##LAST_UPDATED_BY_OPERATOR## (##USER_NAME_LIST##)  AND QRSLT.last_update_date ##LAST_UPDATE_DATE_OPERATOR##  to_date('##SEEDED_DATE##'))
order by QRSLT.NAME, QRSLT.SEQUENCE_NUM*/