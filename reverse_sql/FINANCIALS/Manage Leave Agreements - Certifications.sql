/* ****************************************************************************
 * $Revision: 78239 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 22:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Leave%20Agreements%20-%20Certifications.sql $:
 * $Id: Manage Leave Agreements - Certifications.sql 78239 2022-04-07 15:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=ANC_ABSENCE_AGREEMENTS_VL
-- RSC_PREREQUISITE_OBJECTS=ANC_ABS_AGREEMENT_CERTS_F

SELECT ancABSENAGREEMEO.NAME RES_LEAVE_NAME
,certificatesE0.NAME RES_NAME
,(SELECT MEANING 
	FROM FND_LOOKUP_VALUES 
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'ANC_SETUP_OBJ_MGMT' 
	AND LOOKUP_CODE = certificatesE0.MANAGEMENT_TYPE_CD
	) RES_MANAGEMENT
,(SELECT TERRITORY_SHORT_NAME 
	FROM FND_TERRITORIES_TL 
	WHERE LANGUAGE = USERENV('LANG')
	AND TERRITORY_CODE = certificatesE0.LEGISLATION_CODE
	) RES_LEGISLATION
,TO_CHAR(ancABSAGREECERE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,DECODE(TO_CHAR(ancABSAGREECERE0.EFFECTIVE_END_DATE,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(ancABSAGREECERE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_EFFECTIVE_END_DATE
,ancABSAGREECERE0.LAST_UPDATED_BY 			RSC_LAST_UPDATED_BY
,ancABSAGREECERE0.LAST_UPDATE_DATE 			RSC_LAST_UPDATE_DATE
,ancABSAGREECERE0.CREATED_BY 				RSC_CREATED_BY
,ancABSAGREECERE0.CREATION_DATE 			RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,ancABSENAGREEMEO.LEGISLATION_CODE RSC_COUNTRY_ID

FROM ANC_ABSENCE_AGREEMENTS_VL ancABSENAGREEMEO
,ANC_ABS_AGREEMENT_CERTS_F ancABSAGREECERE0
,ANC_ABS_CERTIFICATIONS_VL certificatesE0
WHERE ancABSENAGREEMEO.ABSENCE_AGREEMENT_ID = ancABSAGREECERE0.ABSENCE_AGREEMENT_ID
AND ancABSAGREECERE0.ABSENCE_CERTIFICATION_ID = certificatesE0.ABSENCE_CERTIFICATION_ID
AND SYSDATE BETWEEN ancABSENAGREEMEO.EFFECTIVE_START_DATE AND ancABSENAGREEMEO.EFFECTIVE_END_DATE
AND SYSDATE BETWEEN ancABSAGREECERE0.EFFECTIVE_START_DATE AND ancABSAGREECERE0.EFFECTIVE_END_DATE
AND SYSDATE BETWEEN certificatesE0.EFFECTIVE_START_DATE AND certificatesE0.EFFECTIVE_END_DATE
ORDER BY ancABSENAGREEMEO.NAME
,certificatesE0.NAME