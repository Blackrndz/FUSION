/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receivables%20Payment%20Terms%20-%20Sequence%20Discounts.sql $:
 * $Id: Manage Receivables Payment Terms - Sequence Discounts.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT QRSLT.SETNAME RES_PAYMENT_TERMS_SET
,QRSLT.NAME RES_NAME
,QRSLT.SEQUENCE_NUM RES_SEQUENCE
,(CASE
	WHEN QRSLT.DISCOUNT_PERCENT < 1 THEN
		'0'||replace(to_char(QRSLT.DISCOUNT_PERCENT,'9,999.99'),' ',null)
	ELSE
		replace(to_char(QRSLT.DISCOUNT_PERCENT,'9,999.99'),' ',null)
	END) RES_PERCENTAGE
,QRSLT.DISCOUNT_DAYS RES_DAYS
,TO_CHAR(QRSLT.DISCOUNT_DATE,'DD-Mon-YYYY') RES_DATE
,QRSLT.DISCOUNT_DAY_OF_MONTH RES_DAY_OF_MONTH
,QRSLT.DISCOUNT_MONTHS_FORWARD RES_MONTHS_AHEAD
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

from (SELECT    RaTermsVl.NAME,
	(SELECT SET_NAME 
		FROM FUSION.FND_SETID_SETS_VL 
		WHERE SET_ID = RATERMSVL.SET_ID 
		) AS SETNAME, 
	RATERMSLINES.SEQUENCE_NUM,  
	RaTermsLinesDiscounts.TERMS_LINES_DISCOUNT_ID,
	RaTermsLinesDiscounts.ATTRIBUTE_CATEGORY,
	RaTermsLinesDiscounts.CREATED_BY, 
	RaTermsLinesDiscounts.CREATION_DATE, 
	RaTermsLinesDiscounts.DISCOUNT_DATE,
	RaTermsLinesDiscounts.DISCOUNT_DAY_OF_MONTH,
	RaTermsLinesDiscounts.DISCOUNT_DAYS,
	RaTermsLinesDiscounts.DISCOUNT_MONTHS_FORWARD,
	RaTermsLinesDiscounts.DISCOUNT_PERCENT,
	RaTermsLinesDiscounts.LAST_UPDATE_DATE,
	RaTermsLinesDiscounts.LAST_UPDATE_LOGIN,
	RaTermsLinesDiscounts.LAST_UPDATED_BY,
	RaTermsLinesDiscounts.OBJECT_VERSION_NUMBER
	FROM FUSION.RA_TERMS_VL RATERMSVL,
	FUSION.RA_TERMS_LINES RATERMSLINES,
	FUSION.RA_TERMS_LINES_DISCOUNTS RaTermsLinesDiscounts
	WHERE RATERMSVL.TERM_ID = RATERMSLINES.TERM_ID 
	AND RATERMSVL.SET_ID = RATERMSLINES.SET_ID 
	and RATERMSLINES.TERM_ID    =  RaTermsLinesDiscounts.TERM_ID
	AND RATERMSLINES.SEQUENCE_NUM = RATERMSLINESDISCOUNTS.SEQUENCE_NUM
	AND RATERMSLINES.SET_ID       = RaTermsLinesDiscounts.SET_ID
	) QRSLT
order by QRSLT.NAME, QRSLT.SEQUENCE_NUM