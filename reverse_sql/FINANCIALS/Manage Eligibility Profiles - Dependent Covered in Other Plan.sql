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
,benELIGDPNTCVRDOTHRPLEO.ORDR_NUM RES_SEQUENCE
,(SELECT NAME FROM BEN_PL_F WHERE PL_ID = benELIGDPNTCVRDOTHRPLEO.PL_ID 
	AND  SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_PLAN_NAME
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = benELIGDPNTCVRDOTHRPLEO.CVG_DET_DT_CD AND LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'BEN_ENRL_DET_DT' AND  SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_DATE_DETERMINATION_RULE
,DECODE(benELIGDPNTCVRDOTHRPLEO.EXCLD_FLAG,'Y','Yes','No') RES_EXCLUDE
,TO_CHAR(benELIGDPNTCVRDOTHRPLEO.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(benELIGDPNTCVRDOTHRPLEO.END_DATE,'DD-Mon-YYYY') RES_END_DATE


,benELIGDPNTCVRDOTHRPLEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,benELIGDPNTCVRDOTHRPLEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,benELIGDPNTCVRDOTHRPLEO.CREATED_BY  RSC_CREATED_BY
,benELIGDPNTCVRDOTHRPLEO.CREATION_DATE  RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_ELIGY_PRFL benELIGYEO
,BEN_ELIG_DPNT_CVRD_OTHR_PL benELIGDPNTCVRDOTHRPLEO
WHERE benELIGYEO.ELIGY_PRFL_ID = benELIGDPNTCVRDOTHRPLEO.ELIGY_PRFL_ID 
AND benELIGYEO.END_DATE BETWEEN benELIGDPNTCVRDOTHRPLEO.START_DATE AND NVL(benELIGDPNTCVRDOTHRPLEO.END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
AND SYSDATE BETWEEN benELIGYEO.START_DATE AND NVL(benELIGYEO.END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
ORDER BY benELIGYEO.NAME,benELIGDPNTCVRDOTHRPLEO.ORDR_NUM