/* ****************************************************************************
* $Revision: 55345 $:
* $Author: wuttipong.thongvises $:
* $Date: 2016-05-23 12:42:33 +0700 (Mon, 23 May 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20Server%20Configurations%20-%20Manage%20Data%20Quality%20Server%20Configurations.sql $:
* $Id: Manage Server Configurations - Manage Data Quality Server Configurations.sql 55345 2016-05-23 05:42:33Z
wuttipong.thongvises $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT benELIGYEO.NAME RES_NAME
,DECODE(COORD_BEN_NO_CVG_FLAG,'Y','Yes','No') RES_OTHER_COVERAGE
,TO_CHAR(benELIGOTHRCVGEO.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(benELIGOTHRCVGEO.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,benELIGOTHRCVGEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,benELIGOTHRCVGEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,benELIGOTHRCVGEO.CREATED_BY  RSC_CREATED_BY
,benELIGOTHRCVGEO.CREATION_DATE  RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_ELIGY_PRFL benELIGYEO
,BEN_ELIG_NO_OTHR_CVG_PRTE benELIGOTHRCVGEO
WHERE SYSDATE BETWEEN benELIGYEO.START_DATE AND NVL(benELIGYEO.END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
AND benELIGYEO.ELIGY_PRFL_ID = benELIGOTHRCVGEO.ELIGY_PRFL_ID 
AND benELIGYEO.END_DATE BETWEEN benELIGOTHRCVGEO.START_DATE AND NVL(benELIGOTHRCVGEO.END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
ORDER BY benELIGYEO.NAME