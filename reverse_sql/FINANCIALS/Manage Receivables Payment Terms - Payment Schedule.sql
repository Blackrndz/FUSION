/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receivables%20Payment%20Terms%20-%20Payment%20Schedule.sql $:
 * $Id: Manage Receivables Payment Terms - Payment Schedule.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 

SELECT distinct QRSLT.SETNAME  RES_PAYMENT_TERMS_SET,
	   QRSLT.NAME 	RES_NAME,
       QRSLT.SEQUENCE_NUM RES_SEQUENCE,
       replace((QRSLT.RELATIVE_AMOUNT),' ',null) RES_RELATIVE_AMOUNT,
       QRSLT.DUE_DAYS RES_DAYS,
       TO_CHAR(QRSLT.DUE_DATE,'DD-Mon-YYYY') RES_DATE,
       QRSLT.DUE_DAY_OF_MONTH RES_DAY_OF_MONTH,
       QRSLT.DUE_MONTHS_FORWARD RES_MONTHS_AHEAD
	   ,QRSLT.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
	   ,QRSLT.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
       ,QRSLT.CREATED_BY  RSC_CREATED_BY
	   ,QRSLT.CREATION_DATE  RSC_CREATION_DATE
	   ,null RSC_LEDGER_ID
	   ,null RSC_CHART_OF_ACCOUNTS_ID
	   ,null RSC_BUSINESS_UNIT_ID
	   ,null RSC_LEGAL_ENTITY_ID
	   ,null RSC_ORGANIZATION_ID
	   ,null RSC_BUSINESS_GROUP_ID
	   ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from 
(SELECT 
   RaTermsVl.NAME,
  (SELECT SET_NAME FROM FUSION.FND_SETID_SETS_VL WHERE SET_ID = RATERMSVL.SET_ID ) AS SETNAME,  
  RaTermsLines.TERM_ID,
  RaTermsLines.ATTRIBUTE_CATEGORY,
  RaTermsLines.CREATED_BY,  
  RaTermsLines.CREATION_DATE,  
  RaTermsLines.DUE_DATE,
  RaTermsLines.DUE_DAY_OF_MONTH,
  RaTermsLines.DUE_DAYS,
  RaTermsLines.DUE_MONTHS_FORWARD,
  RaTermsLines.LAST_UPDATE_DATE,
  RaTermsLines.LAST_UPDATE_LOGIN,
  RaTermsLines.LAST_UPDATED_BY,
  RaTermsLines.OBJECT_VERSION_NUMBER,
  RaTermsLines.RELATIVE_AMOUNT,
  RaTermsLines.SEQUENCE_NUM,
  RATERMSLINES.SET_ID
FROM FUSION.RA_TERMS_VL RATERMSVL,
FUSION.RA_TERMS_LINES RATERMSLINES
WHERE RATERMSVL.TERM_ID = RATERMSLINES.TERM_ID 
AND RATERMSVL.SET_ID = RATERMSLINES.SET_ID 
) QRSLT ,
FUSION.RA_TERMS_LINES_DISCOUNTS RATERMSLINESDISCOUNTS
where QRSLT.TERM_ID    =  RATERMSLINESDISCOUNTS.TERM_ID(+)
AND QRSLT.SEQUENCE_NUM = RATERMSLINESDISCOUNTS.SEQUENCE_NUM(+)
AND QRSLT.SET_ID       = RaTermsLinesDiscounts.SET_ID(+) 
order by QRSLT.NAME, QRSLT.SEQUENCE_NUM