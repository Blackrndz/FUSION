/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Salesperson%20Account%20References%20-%20Manage%20Salesperson%20Account%20References.sql $:
 * $Id: Manage Salesperson Account References - Manage Salesperson Account References.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT QRSLT.name RES_SALESPERSON_NAME
,QRSLT.SALESREP_NUMBER RES_SALESPERSON_NUMBER
,TO_CHAR(QRSLT.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(QRSLT.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE
,DECODE(QRSLT.STATUS,'A','Active','I','Inactive') RES_STATUS
,QRSLT.CREDIT_TYPE_NAME RES_SALES_CREDIT_TYPE
,QRSLT.EMAIL_ADDRESS RES_E_MAIL
,DECODE(QRSLT.SALES_TAX_INSIDE_CITY_LIMITS,'0','Yes','No') RES_INSIDE_CITY_LIMITS
,QRSLT.SET_NAME RES_SALESPERSON_SET
,QRSLT.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY RSC_CREATED_BY
,QRSLT.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT RS.SALESREP_NUMBER
	,RS.NAME
	,RS.SET_ID
	,FSI.SET_NAME
	,RS.SALES_CREDIT_TYPE_ID
	,RS.STATUS
	,RS.RESOURCE_SALESREP_ID
	,RS.START_DATE_ACTIVE
	,RS.END_DATE_ACTIVE
	,HZP.EMAIL_ADDRESS
	,RS.SALES_TAX_INSIDE_CITY_LIMITS
	,ST.NAME CREDIT_TYPE_NAME
	,RS.LAST_UPDATED_BY
	,RS.LAST_UPDATE_DATE
	,RS.CREATED_BY
	,RS.CREATION_DATE
	FROM RA_SALESREPS RS
	,HZ_PARTIES HZP
	,FND_SETID_SETS_VL FSI
	,ar_sales_credit_types ST
	WHERE RS.PARTY_ID           = HZP.PARTY_ID
	AND RS.SET_ID               = FSI.SET_ID
	AND RS.SALES_CREDIT_TYPE_ID = ST.SALES_CREDIT_TYPE_ID(+)
	) QRSLT
ORDER BY QRSLT.name,QRSLT.SALESREP_NUMBER