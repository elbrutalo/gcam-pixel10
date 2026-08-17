.class public Lsgcam/patzi/Dev;
.super Ljava/lang/Object;


.field public static c:Landroid/content/Context;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static init(Landroid/content/Context;)V
    .locals 0

    sput-object p0, Lsgcam/patzi/Dev;->c:Landroid/content/Context;

    return-void
.end method

.method public static full()Z
    .locals 3

    sget-object v0, Lsgcam/patzi/Dev;->c:Landroid/content/Context;

    if-eqz v0, :cond_auto

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "patzicam_ui_mode"

    const-string v2, "auto"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "full"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_notfull

    const/4 v0, 0x1

    return v0

    :cond_notfull
    const-string v1, "sphere"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_auto

    const/4 v0, 0x0

    return v0

    :cond_auto
    invoke-static {}, Lsgcam/patzi/Dev;->known()Z

    move-result v0

    return v0
.end method

.method public static known()Z
    .locals 3

    const-string v0, ",barbet,bluejay,blueline,bonito,bramble,cheetah,coral,crosshatch,felix,flame,husky,lynx,marlin,oriole,panther,pipit,raven,redfin,sailfish,sargo,shiba,sunfish,taimen,tangor,walleye,"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v2, Landroid/os/Build;->DEVICE:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    return v0
.end method
