/*==============================================================*/
/*==============================================================*/
/*==============================================================*/

DECLARE
CURSOR CURSOR_CUENTAS IS
SELECT NUMERO_CUENTA, CEDULA_CLIENTE, FECHA_APERTURA 
FROM CUENTA WHERE FECHA_APERTURA >= SYSDATE-365;

NUMERO CUENTA.NUMERO_CUENTA%TYPE;
CEDULA CUENTA.CEDULA_CLIENTE%TYPE;
FECHA CUENTA.FECHA_APERTURA%TYPE;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Durante el último año se aperturaron las siguientes cuentas: ');
    OPEN CURSOR_CUENTAS;
    
    LOOP
    FETCH CURSOR_CUENTAS INTO NUMERO, CEDULA, FECHA;
    EXIT WHEN CURSOR_CUENTAS%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(NUMERO|| ', ' || NOMBRE|| ', ' || FECHA);
    END LOOP;
    CLOSE CURSOR_CUENTAS;
END;

/*==============================================================*/
/*==============================================================*/
/*==============================================================*/

DECLARE
CURSOR CURSOR_INVERSIONES IS   
SELECT FECHA_INVERSION, CAPITAL_INVERSION, PLAZO_INVERSION, INTERES_INVERSION 
FROM INVERSION WHERE CAPITAL_INVERSION >= 5000;

FECHA INVERSION.FECHA_INVERSION%TYPE;
CAPITAL INVERSION.CAPITAL_INVERSION%TYPE;
PLAZO INVERSION.PLAZO_INVERSION%TYPE;
INTERES INVERSION.INTERES_INVERSION%TYPE;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Las inversiones realizadas con un capital igual o mayor a 5000 dólares son las siguientes: ');
    OPEN CURSOR_INVERSIONES;
    
    LOOP
    FETCH CURSOR_INVERSIONES INTO FECHA, CAPITAL, PLAZO, INTERES;
    EXIT WHEN CURSOR_INVERSIONES%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(FECHA|| ', ' || CAPITAL|| ', ' || PLAZO|| ', ' ||INTERES);
    END LOOP;
    CLOSE CURSOR_INVERSIONES;
END;





/*==============================================================*/
/*==============================================================*/
/*==============================================================*/
DECLARE
CURSOR c_agencia(c_ciudad_agencia varchar2)IS   
SELECT nombre_gerente, codigo_agencia, telefono_agencia
FROM agencia
WHERE ciudad_agencia = c_ciudad_agencia;

BEGIN
DBMS_OUTPUT.PUT_LINE('Información de las Agencias');
    FOR r_agencia IN c_agencia ('Manta')LOOP
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('  Nombre /Cod_agencia /Telefono');
        DBMS_OUTPUT.PUT_LINE(r_agencia.nombre_gerente||'   '||r_agencia.codigo_agencia||'   '||r_agencia.telefono_agencia);
    END LOOP;
END;

/*==============================================================*/
/*==============================================================*/
/*==============================================================*/
DECLARE
CURSOR c_prestamo(ce_cedula_cliente int)IS   
SELECT fecha_prestamo, saldo_prestamo, monto_prestamo
FROM prestamo
WHERE cedula_cliente = ce_cedula_cliente;

BEGIN
DBMS_OUTPUT.PUT_LINE('Información de los prestamos realizados');
    FOR r_prestamo IN c_prestamo ('1315330561')LOOP
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('Fecha  /Saldo  /Monto');
        DBMS_OUTPUT.PUT_LINE(r_prestamo.fecha_prestamo||'   '||r_prestamo.saldo_prestamo||'   '||r_prestamo.monto_prestamo);
    END LOOP;
END;

/*==============================================================*/
/*==============================================================*/
/*==============================================================*/

select * from auditoria_prestamo;


DECLARE
CURSOR c_fecha_aud IS
    SELECT DISTINCT FECHA_AUD
    FROM AUDITORIA_PRESTAMO
    ORDER BY fecha_aud ;

CURSOR c_auditoria(p_fecha_aud date) IS 

SELECT monto_prestamo, saldo_prestamo, fecha_prestamo
FROM AUDITORIA_PRESTAMO
WHERE FECHA_AUD = p_fecha_aud;

BEGIN
    FOR r_fecha_aud IN c_fecha_aud LOOP
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('Fecha_aud');
        DBMS_OUTPUT.PUT_LINE(r_fecha_aud.fecha_aud);
        FOR r_auditoria IN c_auditoria(r_fecha_aud.fecha_aud)LOOP
            DBMS_OUTPUT.PUT_LINE('Monto Saldo Fecha');
            DBMS_OUTPUT.PUT_LINE(r_auditoria.monto_prestamo||' : '||r_auditoria.saldo_prestamo||' : '||r_auditoria.fecha_prestamo);
        END LOOP;
    END LOOP; 
END;


/*==============================================================*/
/*==============================================================*/
/*==============================================================*/

DECLARE
CURSOR C_NUMERO_PRES IS
    SELECT DISTINCT NUMERO_PRES
    FROM PAGO
    ORDER BY NUMERO_PRES ;

CURSOR C_PAGO(P_NUMERO_PRES INTEGER) IS 

SELECT NUMERO_PAGO, FECHA_PAGO, VALOR_PAGO
FROM PAGO
WHERE NUMERO_PRES = P_NUMERO_PRES;

BEGIN
    FOR R_NUMERO_PRES IN C_NUMERO_PRES LOOP
        DBMS_OUTPUT.PUT_LINE('NUMERO DE PRESTAMO');
        DBMS_OUTPUT.PUT_LINE(R_NUMERO_PRES.NUMERO_PRES);
        FOR R_PAGO IN C_PAGO(R_NUMERO_PRES.NUMERO_PRES)LOOP
            DBMS_OUTPUT.PUT_LINE('PAGO');
            DBMS_OUTPUT.PUT_LINE(R_PAGO.NUMERO_PAGO||', '||R_PAGO.FEChA_PAGO||', '||R_PAGO.VALOR_PAGO);
        END LOOP;
    END LOOP; 
END;
